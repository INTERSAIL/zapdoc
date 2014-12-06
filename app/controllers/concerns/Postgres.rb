module Concerns
  module Postgres
    extend ActiveSupport::Concern

    included do
      @valid_ids = []
      before_filter ->(id=params[:folder_id]) {validate_id id}
      before_filter ->(id=params[:id]) {validate_id id}

      cattr_accessor :valid_ids

      self.valid_ids = []
    end

    module ClassMethods
      attr_accessor :valid_ids

      protected
      def valid_id(*args)
        self.valid_ids += Array(args)
      end
    end

    private
    def validate_id(id)
      return head 404 unless valid_id? id
      true
    end

    def valid_id?(id)
      self.class.valid_ids.include?(id) || id =~ /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i
    end
  end
end
