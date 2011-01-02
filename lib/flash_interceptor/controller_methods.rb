require 'spec_helper'

module FlashInterceptor

  module ControllerMethods

    def self.included(base)
      base.send :extend, ClassMethods  
      base.send :include, InstanceMethods
    end

    module ClassMethods

      def before_flash_callbacks
        @before_flash_callbacks ||= []
      end

      def before_flash(*callbacks)
        before_flash_callbacks.concat(callbacks)
      end

      def clear_flash_callbacks
        @before_flash_callbacks = nil
      end

    end

    module InstanceMethods

      def before_flash_callbacks
        self.class.before_flash_callbacks
      end

      def flash
        FlashHashWithCallbacks.new(self, flash_without_callbacks)
      end

    end
  end

end
