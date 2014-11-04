module Api
  class ZFormatsController < ApiController
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

    def show_detailed_exceptions?
      format = ZFormat.find_by(identifier: params[:id])
      if format
        render json: format, status: 200
      else
        render json: {error: 'Format not found'}, status: 404
      end
    end
  end
end