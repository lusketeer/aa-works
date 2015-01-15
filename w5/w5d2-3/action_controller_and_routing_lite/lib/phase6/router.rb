require 'byebug'

module Phase6
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern, @http_method, @controller_class, @action_name = pattern, http_method.to_s.downcase, controller_class, action_name
    end

    # checks if pattern matches path and method matches request method
    def matches?(req)
      pattern_match = !!( req.path =~ @pattern )
      method_match = ( req.request_method.to_s.downcase == @http_method )
      pattern_match && method_match
    end

    # use pattern to pull out route params (save for later?)
    # instantiate controller and call controller action
    def run(req, res)
      route_params = retrieve_route_params(req)
      @controller_class.new(req, res, route_params).invoke_action(@action_name)
    end

    def retrieve_route_params(req)
      route_params = {}
      match_data = @pattern.match(req.path)
      unless match_data.nil?
        match_data.names.each do |name|
          route_params[name] = match_data[name]
        end
      end
      route_params
    end
  end

  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    # simply adds a new route to the list of routes
    def add_route(pattern, method, controller_class, action_name)
      @routes << Route.new(pattern, method, controller_class, action_name)
    end

    # evaluate the proc in the context of the instance
    # for syntactic sugar :)
    def draw(&proc)
      self.instance_eval(&proc)
    end

    # make each of these methods that
    # when called add route
    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method) do |pattern, controller_class, action_name|
        add_route(pattern, http_method, controller_class, action_name)
      end
    end

    # should return the route that matches this request
    def match(req)
      result = @routes.select do |route|
        route if route.matches?(req)
      end
      return nil if result.empty?
      result
    end

    # either throw 404 or call run on a matched route
    def run(req, res)
      if match(req).nil?
        res.status = 404
      else
        match(req).first.run(req, res)
      end
    end
  end
end
