class ZItem < ActiveRecord::Base
  attr_accessor :hierarchy
  scope :of_type, ->(type){where mime_type: type}
  scope :in_folder, ->(folder){where z_item: folder}

  #@jtodoMED add query scopes here for childrens then godo document

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

  def hierarchy
    @hierarchy || initialize_hierarchy
  end

  private

  def initialize_hierarchy
   ZHierarchy.new item: self
  end

  def set_defaults
    self.hierarchy = hierarchy
    self.z_item = self.hierarchy.default
  end

  def historicize
    self.revision = self.revision.nil? ? 1 : self.revision + 1
    ZHistory.create z_item: ZItem.find(self.id) unless self.new_record?
  end

  #@jtodoLOW handle the first and last with timestamp because of uuid as id
end
