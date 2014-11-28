class ZItem < ActiveRecord::Base
  attr_accessor :hierarchy

  #@jtodoIMP add query scopes here for childrens

  # relations
  has_many :z_history, dependent: :destroy
  belongs_to :z_item

  # event hooks
  before_save :historicize
  after_initialize :set_defaults

  # validation
  validates :label, presence: true
  validates :revision, numericality: true, presence: true, unless: ->{ self.new_record? }

  # aliases
  alias_attribute :identifier, :id
  alias histories z_history
  alias folder z_item

  #
  #@jtodoIMP put this in hierarchy
  # def self.in_folder(folder)
  #   self.where(folder: folder)
  # end

  #@jtodoIMP implement that and create the item_type column
  # def self.of_type(type)
  #   self.where(_type: type)
  # end
  #

  private

  def set_defaults
    self.hierarchy = ZHierarchy.new item: self
    self.z_item = self.hierarchy.default
  end

  def historicize
    self.revision = self.revision.nil? ? 1 : self.revision + 1
    ZHistory.create(z_item: ZItem.find(self.id)) unless self.new_record?
  end

  #@jtodoLOW handle the first and last with timestamp because of uuid as id
end
