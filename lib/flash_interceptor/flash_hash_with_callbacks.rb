module FlashInterceptor

  class FlashHashWithCallbacks
    attr_accessor :controller, :flash

    def initialize(kontroller, flash)
      @controller = kontroller  
      @flash = flash
    end

    def [](v)
      @flash[v]
    end

    def []=(k, v)
      @controller.perform_before_flash_callbacks(v)
      @flash[k] = v
    end

    def each(&block)
      @flash.each &block 
    end

    def now
      self.flash = @flash.now
      self
    end

  end

end
