module Api
  class ZItemsController < BaseItemsController
    def index
      if @folder.nil?
        render json: {error: 'Folder not found'}, status: :not_found
      else
        items = ZItem.in_folder(@folder).to_a

        unless @folder.root?
          @folder.folder.label = '..'
          items.unshift(@folder.folder)
        end

        render json: items, status: :ok
      end
    end

    def show
      item = ZItem.find_by(identifier: params[:id])
      if item
        render json: item, status: :ok
      else
        render json: {error: 'Item not found'}, status: :not_found
      end
    end
  end
end