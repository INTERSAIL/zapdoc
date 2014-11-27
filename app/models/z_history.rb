class ZHistory < ActiveRecord::Base
  # relations
  belongs_to :z_item

  # event hooks
  before_validation :set_defaults

  # validation
  validates :z_item, presence: true
  validates :revision, presence: true, numericality: true

  private

  def set_defaults
    self.revision = self.z_item.revision unless self.z_item.nil?
    self.history_date = Time.now
  end

end
