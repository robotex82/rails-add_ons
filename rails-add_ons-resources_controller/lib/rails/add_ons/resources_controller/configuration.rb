module Rails
  module AddOns
    module ResourcesController
      module Configuration
        def configure
          yield self
        end
      end
    end
  end
end