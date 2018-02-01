module ServiceController::RestServiceUrls
  extend ActiveSupport::Concern
  
  included do
    helper_method :collection_path,
                  :call_service_path,
                  :invoke_service_path
  end

  def collection_path
    resource_router.send(:url_for, { action: :index, only_path: true })
  end

  def invoke_service_path
    resource_router.send(:url_for, { action: :invoke, only_path: true })
  end

  def call_service_path
    resource_router.send(:url_for, { action: :call, only_path: true })
  end

  def resource_router
    self
  end
end
