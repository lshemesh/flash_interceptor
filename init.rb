require 'flash_interceptor'

ActionController::Base.send :include, FlashInterceptor::ControllerMethods
