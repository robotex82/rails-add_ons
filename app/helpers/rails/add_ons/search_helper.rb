module Rails
  module AddOns
    module AutosubmitHelper
      # Example:
      #
      #     = search_form_for(@collection, url: collection_path, method: :get) do |f|
      #       = f.input :title_cont
      #       = f.input :product_number_cont
      #       = f.input :active_eq
      #       = f.submit
      #
      def search_form_for(collection, options = {}, &block)
        wrapped_collection = SearchableCollection.new(collection, params[:q])
        # simple_form_for(wrapped_collection, options.merge(scope: 'q'), &block)
        simple_form_for(wrapped_collection, options.merge(as: :q), &block)
      end

      class SearchableCollection
        include ActiveModel::Model

        def method_missing(method, *args)
          if method.to_s.match(/(.+)_(gt|gt_or_eq|eq|not_eq|lt_or_eq|lt|null|not_null|cont)/)
            @query.send(:[], method)
          else
            super
          end
        end

        def initialize(collection, query)
          @collection = collection
          @query = query || {}
        end
      end
    end
  end
end