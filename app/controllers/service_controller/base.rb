module ServiceController
  class Base < ::FrontendController
    layout 'rails/add_ons/application'

    include Service
    include RestActions
    include RestServiceUrls
    include ResourceInflections
    include LocationHistory
  end
end
