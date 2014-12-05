module Api
  class BaseItemsController < ApiController
    # filters
    before_filter :set_folder, only: :index
  end
end
