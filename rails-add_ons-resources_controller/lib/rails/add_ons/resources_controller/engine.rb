module Rails
  module AddOns
    module ResourcesController
      class Engine < ::Rails::Engine
        isolate_namespace Rails::AddOns::ResourcesController
      end
    end
  end
end
