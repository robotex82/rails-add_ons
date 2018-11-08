module Rails
  module AddOns
    module ResourcesController::RestResourceUrlsConcern
      extend ActiveSupport::Concern

      included do
        helper_method :new_resource_path
        helper_method :collection_path
        helper_method :resource_path
        helper_method :edit_resource_path
      end

      private

      def new_resource_path
        resource_router.send(:url_for, { action: :new, only_path: true })
      end

      def collection_path
        resource_router.send(:url_for, { action: :index, only_path: true })
      end

      def resource_path(resource)
        resource_router.send(:url_for, { action: :show, id: resource, only_path: true })
      end

      def edit_resource_path(resource)
        resource_router.send(:url_for, { action: :edit, id: resource, only_path: true })
      end

      def resource_router
        self
      end
    end
  end
end
