module ServiceController
  class Base < ::FrontendController
    layout 'rails/add_ons/application'

    include ServiceController::Service
    include ServiceController::RestActions
    include ServiceController::RestServiceUrls
    include ServiceController::ServiceInflections
    include ServiceController::LocationHistory
  end
end
