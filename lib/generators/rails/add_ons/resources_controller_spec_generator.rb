module Rails
  module AddOns
    # This will generate specs for create, read, update, delete and list.
    # 
    # Example:
    # 
    #     rails g rails:add_ons:resources_controller_spec --uri /de/backend/uploads
    #       create  spec/features/de/backend/uploads_feature_spec.rb
    #
    class ResourcesControllerSpecGenerator < Rails::Generators::Base
      desc 'Generates CRUDL specs for REST resources'

      source_root File.expand_path('../templates', __FILE__)
 
      class_option :uri, type: :string, required: true

      def uri
        @uri ||= options['uri']
      end

      def edit_form_dom_selector
        ".edit_#{resource_class.demodulize.underscore}"
      end

      def new_form_dom_selector
        "#new_#{resource_class.demodulize.underscore}"
      end

      def resource_class
        @resource_class ||= ENV.fetch('RESOURCE_CLASS') { @uri.split('/').last.camelize.singularize }
      end

      def factory_name
        underscored_resource_class
      end

      def underscored_resource_class
        @undescored_resource_class ||= resource_class.underscore.gsub('/', '_')
      end

      def generate_spec
        template 'spec.rb', "spec/features#{uri}_feature_spec.rb"
      end
    end
  end
end