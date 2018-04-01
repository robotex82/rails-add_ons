module ServiceController
  class Base < Rails::AddOns::Configuration.service_controller_base_class_name.constantize
    layout 'rails/add_ons/application'

    include ServiceController::Service
    include ServiceController::RestActions
    include ServiceController::RestServiceUrls
    include ServiceController::ServiceInflections
    include ServiceController::LocationHistory
  end
end
