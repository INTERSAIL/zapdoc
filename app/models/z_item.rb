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
  field :format_identifier, type: String
  field :mime_type, type: String

  belongs_to :folder, class_name: 'ZFolder'

  index({ identifier: 1 }, { unique: true })

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :revision, numericality: true, presence: true, unless: ->{ self.new_record? }

  def histories
    ZHistory.where(item_identifier: self.identifier)
  end

  def self.in_folder(folder)
    self.where(folder: folder)
  end
  def self.of_type(type)
    self.where(_type: type)
  end

  private
  def set_defaults
    self.identifier ||= SecureRandom.uuid
  end

  def historicize
    self.revision = self.revision.nil? ? 1 : self.revision + 1

    ZHistory.create(item: ZItem.find(self.id)) unless self.new_record?
  end
end
