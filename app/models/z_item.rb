  class ZItem
    include Mongoid::Document
    include Mongoid::Timestamps

    after_initialize :set_defaults
    before_save :historicize

    field :identifier, type: String
    field :label, type: String
    field :custom_attributes, type: Hash
    field :tags, type: Array
    field :revision, type: Integer

    index({ identifier: 1 }, { unique: true })

    validates :identifier, presence: true

    private
    def set_defaults
      self.identifier ||= SecureRandom.uuid
    end

    def historicize
      self.revision = self.revision ? self.revision+1 : 1

      h = ZHistory.create(item: ZItem.find(self.id)) unless self.new_record?
    end
  end
