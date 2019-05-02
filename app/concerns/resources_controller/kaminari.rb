module ResourcesController
  module Kaminari
    def self.included(base)
      base.helper_method :paginate?
    end

    def paginate?
      true
    end

    private

    def load_collection
      @collection = load_collection_scope.page(params[:page]).per(per_page)
    end

    def per_page
      if [nil, 'all'].include?(params[:per_page])
        count = load_collection_scope.count
        count > 0 ? count : nil
      else
        Rails::AddOns::Configuration.pagination_per_page_default
      end
    end
  end
end
