module Api
  class ZItemsController < ApplicationController
    before_filter :set_folder, only: :index

    def index
      items = ZItem.in_folder(@folder)

      render json: ZItemInfo.from_z_item(items), status: 200
    end

    def show
      item = ZItem.find(params[:id])
      if item
        render json: item, status: 200
      else
        render json: {error: 'Item not found'}, status: 404
      end
    end

    private
    def set_folder
      fid = params['folder_id']
      if fid
        @folder = fid=='0' ? ZFolder.root : ZFolder.find(fid)
      else
        @folder = ZFolder.root
      end
      if @folder.nil?
        render json: {error: 'Folder not found'}, status: 404
        return false
      end
    end
  end
end