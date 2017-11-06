module ResourcesController::WillPaginate
  extend ActiveSupport::Concern

  included do
    helper_method :paginate?
  end

  def paginate?
    true
  end

  private

  def load_collection
    @collection = load_collection_scope.paginate(page: params[:page])
  end
end
