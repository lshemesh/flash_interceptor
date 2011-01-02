module ActionController
  module Flash
    module InstanceMethods
      alias_method :flash_without_logging, :flash
    end
  end
end
