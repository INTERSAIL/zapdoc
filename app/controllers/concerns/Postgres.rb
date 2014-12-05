module Concerns
  module Postgres
    extend ActiveSupport::Concern

    included do
      @@valid_ids = []
      before_filter :validate_id
    end

    def validate_id
      return unless params.has_key? :folder_id
      return head 404 unless valid_id params[:folder_id]
    end

    def valid_id(id)
      id =~ /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i || (@@valid_ids.include? id)
    end
  end
end
