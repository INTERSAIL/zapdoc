module Api
  class ZFormatsController < ApplicationController
    def index
      formats = ZFormat.all
      render json: formats, status: 200
    end

    def default
      format = ZFormat.find_by(default: true)
      if format
        render json: format, status: 200
      else
        render json: {error: 'Default format not found' }, status: 404
      end
    end
  end
end