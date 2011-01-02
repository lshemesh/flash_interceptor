require 'flash_logger'

ActionController::Base.send :include, FlashLogger::ControllerMethods
