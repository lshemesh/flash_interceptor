require 'flash_logger/flash'
require 'flash_logger/flash_hash_with_logger'

module FlashLogger

  module ControllerMethods

    def self.included(base)
      base.send :extend, ClassMethods  
    end

    module ClassMethods
      def log_flash_messages
        send :include, InstanceMethods
      end
    end

    module InstanceMethods

      def flash
        FlashHashWithLogger.new(self, flash_without_logging)
      end

      def log(type, message)
        data = { 
          :type       => type,
          :message    => message,
          :url        => request.request_uri,
          :user_agent => request.user_agent,
          :ip_address => request.remote_ip,
          :user_id    => current_user,
          :session    => request.session_options['id'] if request.session_options
        }
        session['error_log'] = FlashMessages.create(data).id
      rescue Exception => e
        logger.debug(e.message);
      end
    end
  end

end

ActionController::Base.send :include, FlashLogger::ControllerMethods
