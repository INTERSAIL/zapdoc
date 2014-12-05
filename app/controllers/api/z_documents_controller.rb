module Api
  class ZDocumentsController < BaseItemsController
    def index
      if @folder.nil?
        render json: {error: 'Folder not found'}, status: :not_found
      else
        documents = ZDocument.in_folder(@folder)

        render json: documents, status: :ok
      end
    end

    def show
      document = ZDocument.find(params[:id])
      if document
        render json: document, status: :not_found
      else
        render json: {error: 'Item not found'}, status: :ok
      end
    end
  end
end