module FlashLogger

  class FlashHashWithLogger
    attr_accessor :controller, :flash

    KEYS_TO_LOG = [
      :notice,
      :failure,
      :error
    ]

    def initialize(kontroller, flash)
      @controller = kontroller  
      @flash = flash
    end

    def [](v)
      @flash[v]
    end

    def []=(k, v)
      @controller.log(v) if KEYS_TO_LOG.include?(k)
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
