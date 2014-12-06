module Concerns
  module Postgres
    extend ActiveSupport::Concern

    included do
      private
      cattr_accessor :valid_ids
      self.valid_ids = []
    end

    module ClassMethods
      protected
      def check_params(*args)
        Array(args).each { |param| before_action ->(id=params[param]) { validate_id id }, if: ->{ params.has_key?(param) } }
      end
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
      self.class.valid_ids.include?(id) || /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i === id
    end
  end
end
