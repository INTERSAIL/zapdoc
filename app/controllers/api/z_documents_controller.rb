module Api
  class ZDocumentsController < BaseItemsController
    def index
      if @folder.nil?
        render json: {error: 'Folder not found'}, status: 404
      else
        documents = ZDocument.in_folder(@folder)

        render json: ZItemInfo.from_z_item(documents), status: 200
      end
    end

    def show
      document = ZDocument.find_by(identifier: params[:id])
      if document
        render json: ZDocumentInfo.from_z_item(document), status: 200
      else
        render json: {error: 'Item not found'}, status: 404
      end
    end
  end
end