module ServiceController::ServiceInflections
  extend ActiveSupport::Concern

  included do
    helper_method :inflections
  end

  private

  def inflections
    {
      service_name: service_class.model_name.human(count: 1)
    }
  end
end
