module Rails
  module AddOns
    module ResourcesController
      class Base < Rails::AddOns::Configuration.resources_controller_base_class_name.constantize
        include RestActionsConcern
        include ResourcesConcern
        include RestResourceUrlsConcern
        include ResourceInflectionsConcern
        include LocationHistoryConcern
        include ::Rails::AddOns::Controller::QueryConditionsConcern

        private

        def load_collection_scope
          add_conditions_from_query(resource_class)
        end
      end
    end
  end
end