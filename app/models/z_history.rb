class ZHistory < ActiveRecord::Base
  #@jtodoIMP finish check here then goto the infos classes
  # relations
  belongs_to :item, class_name: ZItem, foreign_key: :z_item_id

  # event hooks
  before_validation :set_defaults

  # validation
  validates :item, presence: true
  validates :revision, presence: true, numericality: true

  private

  def set_defaults
    self.revision = self.item.revision unless self.item.nil?
    self.history_date = Time.now
  end
end
