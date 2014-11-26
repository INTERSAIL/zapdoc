class ZHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :item, class_name: "ZItem"
  field :history_date, type: DateTime
  field :item_identifier, type: String
  field :revision, type: Integer

  index({ item_identifier: 1, revision: 1 }, { unique: true })

  validates :item, presence: true
  validates :item_identifier, presence: true
  validates :revision, presence: true

  before_validation :set_defaults

  private
  def set_defaults
    self.revision = self.item.revision
    self.item_identifier = self.item.identifier
    self.history_date = Time.now
  end
end