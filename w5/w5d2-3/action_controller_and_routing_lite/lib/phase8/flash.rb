module Phase8
  class Flash
    def initialize(req)
      @flash = {}
      cookie = req.cookies.find {|c| c.name == "flash" }
      if cookie
        JSON.parse(cookie.value).each do |key, val|
          @flash[key] = val
        end
      else
        req.cookies << WEBrick::Cookie.new("flash", {}.to_json)
      end
    end

    def []=(key, val)
      @flash[key] = val
    end

    def [](key)
      @flash[key]
    end

    def now
      Now.new
    end

    def store_flash(res)
      res.cookies << WEBrick::Cookie.new("flash", @flash.to_json)
    end
  end

  class Now

  end
end
