class ZItem < ActiveRecord::Base
  attr_accessor :hierarchy
  #scopes
  scope :of_type, ->(type){where mime_type: type}
  scope :in_folder, ->(folder){where folder: folder}

  # relations
  #@jtodoLOW use ZFolder class instead and fix the circular dependency if using ZFolder
  belongs_to :folder, class_name: ZItem, foreign_key: :z_item_id
  has_many :histories, class_name: ZHistory, dependent: :destroy

  # event hooks
  before_save :historicize
  after_initialize :set_defaults

  # validation
  validates :label, presence: true
  validates :revision, numericality: true, presence: true, unless: ->{ self.new_record? }

  # aliases
  alias_attribute :identifier, :id

  def hierarchy
    @hierarchy || initialize_hierarchy
  end

  private

  def initialize_hierarchy
   ZHierarchy.new item: self
  end

  def set_defaults
    self.hierarchy = hierarchy
    self.folder = self.hierarchy.default
  end

  def historicize
    self.revision = self.revision.nil? ? 1 : self.revision + 1
    ZHistory.create item: ZItem.find(self.id) unless self.new_record?
  end

  #@jtodoLOW handle the first and last with timestamp because of uuid as id
end
