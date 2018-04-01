module ResourcesController
  class Base < Rails::AddOns::Configuration.resources_controller_base_class_name.constantize
    layout 'rails/add_ons/application'

    include RestActions
    include Resources
    include RestResourceUrls
    include ResourceInflections
    include LocationHistory
    include ::Controller::QueryConditions

    private

    def load_collection_scope
      add_conditions_from_query(resource_class)
    end
  end
end
