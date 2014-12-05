module Concerns
  module Postgres
    extend ActiveSupport::Concern

    included do
      @@valid_ids = []
      before_filter ->(id=params[:folder_id]) {validate_id id}
      before_filter ->(id=params[:id]) {validate_id id}
    end

    def validate_id(id)
      return if id.nil?
      return head 404 unless valid_id? id
    end

    def valid_id?(id)
      id =~ /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i || (@@valid_ids.include? id)
    end
  end
end
