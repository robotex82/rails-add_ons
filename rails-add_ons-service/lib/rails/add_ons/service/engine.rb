module Rails
  module AddOns
    module Service
      class Engine < ::Rails::Engine
        isolate_namespace Rails::AddOns::Service
      end
    end
  end
end
