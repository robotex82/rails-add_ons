module ResourcesController
  module RestActions
    extend ActiveSupport::Concern

    included do
      include ActionController::MimeResponds

      respond_to :html
      responders :flash

      if respond_to?(:before_action)
        before_action :load_collection, only: [:index]
        before_action :load_resource, only: [:show, :edit, :destroy, :update]
        before_action :initialize_resource, only: [:new]
        before_action :initialize_resource_for_create, only: [:create]
        before_action :before_rest_action, if: -> { respond_to?(:before_rest_action, true) }
      else
        before_filter :load_collection, only: [:index]
        before_filter :load_resource, only: [:show, :edit, :destroy, :update]
        before_filter :initialize_resource, only: [:new]
        before_filter :initialize_resource_for_create, only: [:create]
      end
    end

    def index; end
    def new; end
    def show; end
    def edit; end

    def update
      if @resource.send(update_method_name, permitted_params) && respond_to?(:after_update_location, true) && after_update_location.present?
        respond_with(respond_with_namespace, @resource, location: after_update_location)
      else
        respond_with(respond_with_namespace, @resource)
      end
    end

    def destroy
      @resource.destroy
      if respond_to?(:after_destroy_location, true) && after_destroy_location.present?
        respond_with(respond_with_namespace, @resource, location: after_destroy_location)
      else
        respond_with(respond_with_namespace, @resource)
      end
    end

    def create
      if @resource.save && respond_to?(:after_create_location, true) && after_create_location.present?
        respond_with(respond_with_namespace, @resource, location: after_create_location)
      else
        respond_with(respond_with_namespace, @resource)
      end
    end

    private

    def update_method_name
      Rails::VERSION::MAJOR < 4 ? :update_attributes : :update
    end

    def respond_with_namespace
      nil
    end

    def load_collection_scope
      resource_class
    end

    def load_collection
      @collection = load_collection_scope.all
    end

    def load_resource_scope
      resource_class
    end

    def load_resource
      @resource = load_resource_scope.find(params[:id])
    end

    def initialize_resource
      @resource = resource_class.new
    end

    def initialize_resource_for_create
      @resource = resource_class.new(permitted_params)
    end

    def permitted_params
      raise "not implemented"
    end
  end
end
