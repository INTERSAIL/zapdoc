module ZapDoc
  class Item
    include Mongoid::Document
    include Mongoid::Timestamps

    after_initialize :set_defaults

    field :identifier, type: String
    field :label, type: String
    field :custom_attributes, type: Hash
    field :tags, type: Array

    index({ identifier: 1 }, { unique: true })

    validates :identifier, presence: true, uniqueness: true

    private
    def set_defaults
      self.identifier ||= SecureRandom.uuid
    end
  end
end