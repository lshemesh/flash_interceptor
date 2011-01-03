module FlashInterceptor

  module ControllerMethods

    def self.included(base)
      base.send :extend, ClassMethods  
      base.send :include, InstanceMethods
    end

    module ClassMethods

      def clear_flash_callbacks
        @@before_flash_callbacks = nil
      end

      def before_flash(*callbacks)
        puts "called before_flash with #{callbacks}"
        before_flash_callbacks.concat(callbacks)
      end

      def before_flash_callbacks
        @@before_flash_callbacks ||= []
      end

    end

    module InstanceMethods

      def perform_before_flash_callbacks(message)
        before_flash_callbacks.each do |callback|
          send callback, message
        end
      end

      def flash
        FlashHashWithCallbacks.new(self, flash_without_callbacks)
      end

      private

        def before_flash_callbacks
          self.class.before_flash_callbacks
        end

    end

  end

end
