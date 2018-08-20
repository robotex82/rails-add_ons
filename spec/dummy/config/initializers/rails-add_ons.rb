Rails::AddOns.configure do |config|
  # Set the default format for timestamps in tables.
  #
  # Default: config.table_default_timestamp_format = nil
  #
  config.table_default_timestamp_format = nil

  # Sets the parent controller for Api::ServiceController::Base
  #
  # default: config.api_service_controller_base_class_name = '::ApiController'
  #
  config.api_service_controller_base_class_name = '::ApiController'

  # Sets the parent controller for Api::ResourcesController::Base
  #
  # default: config.api_resources_controller_base_class_name = '::ApiController'
  #
  config.api_resources_controller_base_class_name = '::ApiController'

  # Sets the parent controller for ServiceController::Base
  #
  # default: config.service_controller_base_class_name = '::FrontendController'
  #
  config.service_controller_base_class_name = '::FrontendController'

  # Sets the parent controller for ResourcesController::Base
  #
  # default: config.resources_controller_base_class_name = '::FrontendController'
  #
  config.resources_controller_base_class_name = '::FrontendController'
end
