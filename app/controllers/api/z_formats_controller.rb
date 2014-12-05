module Api
  class ZFormatsController < ApiController
    def index
      formats = ZFormat.all
      render json: formats, status: :ok
    end

    def default
      format = ZFormat.find_by(default: true)
      if format
        render json: format, status: :ok
      else
        render json: {error: 'Default format not found' }, status: :not_found
      end
    end

    def show_detailed_exceptions?
      format = ZFormat.find(params[:id])
      if format
        render json: format, status: :ok
      else
        render json: {error: 'Format not found'}, status: :not_found
      end
    end
  end
end