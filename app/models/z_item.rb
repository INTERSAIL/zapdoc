class ZItem < ActiveRecord::Base
  #@jtodoIMP handle the first and last with timestamp

  alias_attribute :identifier, :id

  # after_initialize :set_defaults
  before_save :historicize

  has_many :z_history, dependent: :destroy
  alias histories z_history

  #@jtodoIMP add getter for identifier that gives the id for backward compatibility

  validates :label, presence: true
  validates :revision, numericality: true, presence: true, unless: ->{ self.new_record? }
  #
  #@jtodo check for test of this
  # def self.in_folder(folder)
  #   self.where(folder: folder)
  # end
  # def self.of_type(type)
  #   self.where(_type: type)
  # end
  #

  private

  # def set_defaults
  #   self.folder ||= ZFolder.root unless (self.respond_to?(:root?) && self.root?)
  # end

  def historicize
    self.revision = self.revision.nil? ? 1 : self.revision + 1

    ZHistory.create(z_item: ZItem.find(self.id)) unless self.new_record?
  end
end
