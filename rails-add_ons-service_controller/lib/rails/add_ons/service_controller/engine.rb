module Rails
  module AddOns
    module ServiceController
      class Engine < ::Rails::Engine
        isolate_namespace Rails::AddOns::ServiceController
      end
    end
  end
end
