require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      parse_www_encoded_form(req.query_string || req.body)
      @params = @params.merge(route_params)
    end

    def [](key)
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      if www_encoded_form
        URI::decode_www_form(www_encoded_form).each do |key, value|
          h = parse_key(key).reverse.inject(value) {|f, s| {s => f} }
          @params = deep_merge(@params, h)
        end
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      regex = /\]\[|\[|\]/
      key.split(regex)
    end

    def deep_merge(h1, h2)
      h1.merge(h2) { |key, h1_elem, h2_elem| deep_merge(h1_elem, h2_elem) }
    end
  end
end
