module Rails
  module AddOns
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:table_default_timestamp_format)           { :short }
      mattr_accessor(:api_service_controller_base_class_name)   { '::ApiController' }
      mattr_accessor(:api_resources_controller_base_class_name) { '::ApiController' }
      mattr_accessor(:service_controller_base_class_name)       { '::FrontendController' }
      mattr_accessor(:resources_controller_base_class_name)     { '::FrontendController' }
      mattr_accessor(:pagination_per_page_default)              { 25 }
    end
  end
end
