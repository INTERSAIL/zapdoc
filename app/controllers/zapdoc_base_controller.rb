class ZapdocBaseController < ActionController::Base

  protected
  def set_folder
    fid = params['folder_id']
    if fid
      @folder = fid=='0' ? ZFolder.root : ZFolder.find_by(identifier: fid)
    else
      @folder = ZFolder.root
    end
    if @folder.nil?
      render json: {error: 'Folder not found'}, status: 404
      false
    end
  end
end