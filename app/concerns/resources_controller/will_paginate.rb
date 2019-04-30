module ResourcesController
  module WillPaginate
    extend ActiveSupport::Concern

    included do
      helper_method :paginate?
    end

    def paginate?
      true
    end

    private

    def load_collection
      options = { page: params[:page] }
      options[:per_page] = per_page unless per_page.nil?
      @collection = load_collection_scope.paginate(options)
    end

    def per_page
      if [nil, 'all'].include?(params[:per_page])
        nil
      else
        Rails::AddOns::Configuration.pagination_per_page_default
      end
    end
  end
end
