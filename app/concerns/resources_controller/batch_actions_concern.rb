module ResourcesController
  module BatchActionsConcern
    def destroy_many
      @collection = load_collection_scope.where(id: params[:ids])
      @collection.destroy_all

      respond_with @collection, location: after_destroy_many_location, noticse: t('.success')
    end

    private

    def after_destroy_many_location
      collection_path
    end
  end
end