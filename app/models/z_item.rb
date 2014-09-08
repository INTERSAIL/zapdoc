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

  belongs_to :folder, class_name: 'ZFolder'

  index({ identifier: 1 }, { unique: true })

  validates :identifier, presence: true, uniqueness: true

  def histories
    ZHistory.where(item_identifier: self.identifier)
  end

  private
  def set_defaults
    self.identifier ||= SecureRandom.uuid
  end

  def historicize
    self.revision = self.revision ? self.revision+1 : 1

    ZHistory.create(item: ZItem.find(self.id)) unless self.new_record?
  end
end
