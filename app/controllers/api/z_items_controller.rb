module Api
  class ZItemsController < BaseItemsController
    def index
      if @folder.nil?
        render json: {error: 'Folder not found'}, status: 404
      else
        items = ZItem.in_folder(@folder).to_a

        unless @folder.root?
          @folder.folder.label = '..'
          items.unshift(@folder.folder)
        end

        render json: ZItemInfo.from_z_item(items), status: 200
      end
    end

    def show
      item = ZItem.find_by(identifier: params[:id])
      if item
        render json: item, status: 200
      else
        render json: {error: 'Item not found'}, status: 404
      end
    end
  end
end