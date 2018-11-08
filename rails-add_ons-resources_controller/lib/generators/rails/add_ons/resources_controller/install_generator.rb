module Rails
  module AddOns
    module ResourcesController
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc 'Generates the initializer'

          source_root File.expand_path('../templates', __FILE__)

          def generate_initializer
            template 'initializer.rb', 'config/initializers/rails-add_ons-resources_controller.rb'
          end
        end
      end
    end
  end
end