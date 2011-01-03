module FlashInterceptor

  module ControllerMethods

    def self.included(base)
      base.send :extend, ClassMethods  
      base.send :include, InstanceMethods
    end

    module ClassMethods

      @@before_flash_callbacks = []

      def clear_flash_callbacks
        @@before_flash_callbacks = []
      end

      def before_flash(*callbacks)
        @@before_flash_callbacks |= callbacks
      end

      def before_flash_callbacks
        @@before_flash_callbacks
      end

    end

    module InstanceMethods

      def perform_before_flash_callbacks(type, message)
        before_flash_callbacks.each do |callback|
          send callback, type, message
        end
      end

      def flash
        FlashHashWithCallbacks.new(self, flash_without_callbacks)
      end

      def before_flash_callbacks
        self.class.before_flash_callbacks
      end

    end

  end

end
