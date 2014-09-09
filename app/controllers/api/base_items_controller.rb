module Api
  class BaseItemsController < ApplicationController
    before_filter :set_folder, only: :index

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
