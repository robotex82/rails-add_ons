module ResourcesController::RestActions
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
    if Rails::VERSION::MAJOR < 4
      @resource.update_attributes(permitted_params)
    else
      @resource.update(permitted_params)
    end
    respond_with(respond_with_namespace, @resource)
  end

  def destroy
    @resource.destroy
    respond_with(respond_with_namespace, @resource)
  end

  def create
    @resource.save
    respond_with(respond_with_namespace, @resource)
  end

  private

  def respond_with_namespace
    nil
  end

  def after_create_location
    ->(controller) { resource_path(@resource) }
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
