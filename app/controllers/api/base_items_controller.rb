module Api
  class BaseItemsController < ApiController
    before_filter :set_folder, only: :index
  end
end
