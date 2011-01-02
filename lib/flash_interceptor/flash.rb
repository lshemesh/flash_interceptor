module ActionController
  module Flash
    module InstanceMethods
      alias_method :flash_without_callbacks, :flash
    end
  end
end
