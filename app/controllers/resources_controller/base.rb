module ResourcesController
  class Base < ::FrontendController
    layout 'rails/add_ons/application'

    include RestActions
    include Resources
    include RestResourceUrls
    include ResourceInflections
    include LocationHistory
  end
end
