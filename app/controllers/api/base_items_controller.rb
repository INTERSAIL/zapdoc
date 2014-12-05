module Api
  class BaseItemsController < ApiController
    include Concerns::Postgres
    # filters
    # set extra valid id for postgres filter
    valid_id nil, '0'
    before_filter :set_folder , only: :index

    protected
    def set_folder
      fid = params['folder_id']
      if fid
        @folder = fid=='0' ? ZHierarchy.root : ZFolder.find(fid)
      else
        @folder = ZHierarchy.root
      end
      if @folder.nil?
        render json: {error: 'Folder not found'}, status: :not_found
        false
      end
    end
  end
end
