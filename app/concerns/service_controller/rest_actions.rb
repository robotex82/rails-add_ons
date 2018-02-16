module ServiceController::RestActions
  extend ActiveSupport::Concern

  included do
    respond_to :html
    responders :flash

    if respond_to?(:before_action)
      before_action :initialize_service_for_invoke, only: [:invoke]
      before_action :initialize_service_for_call, only: [:call]
    else
      before_filter :initialize_service_for_invoke, only: [:invoke]
      before_filter :initialize_service_for_call, only: [:call]
    end
  end

  def index
  end

  def invoke
    respond_with @service
  end

  def call
    @result = execute_service
    if @result.success?

      if respond_to?(:after_success_location)
        redirect_to(after_success_location, notice: success_message)
      else
        flash.now[:success] = success_message
        render :success
      end
    else
      render :invoke
    end
  end

  private

  def success_message
    t('flash.actions.perform.notice', resource_name: @resource.class.model_name.human)
  end

  def execute_service
    @service.send(execute_method)
  end

  def execute_method
    :perform
  end

  def hashified_params
    if permitted_params.respond_to?(:to_h)
      permitted_params.to_h
    else
      permitted_params
    end
  end

  def initialize_service_for_invoke
    @service = service_class.new
  end

  def initialize_service_for_call
    @service = service_class.new(hashified_params)
  end

  def permitted_params
    raise "Not implemented"
  end
end
