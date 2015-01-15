require_relative '../phase6/controller_base'
require_relative './flash'

module Phase8
  class ControllerBase < Phase6::ControllerBase
    attr_reader :flash

    def flash
      @flash ||= Phase8::Flash.new(@req)
    end

    def render_content(content, type)
      flash.store_flash(@res)
      super(content, type)
    end

    def redirect_to(url)
      super(url)
      flash.store_flash(@res)
    end
  end
end
