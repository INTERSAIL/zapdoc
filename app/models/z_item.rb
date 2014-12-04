class ZItem < ActiveRecord::Base
  attr_accessor :hierarchy
  #scopes
  scope :of_type, ->(type){where mime_type: type}
  scope :in_folder, ->(folder){where folder: folder}

  # relations
  belongs_to :folder, class_name: :ZFolder, foreign_key: :z_item_id
  has_many :histories, class_name: :ZHistory, dependent: :destroy

  # event hooks
  before_save :historicize
  after_initialize :set_defaults

  # validation
  validates :label, presence: true
  validates :revision, numericality: true, presence: true, unless: ->{ self.new_record? }

  #@jtodoMED add folder required validation

  # aliases
  alias_attribute :identifier, :id

  private

  def initialize_hierarchy
    self.hierarchy ||= ZHierarchy.new self
  end

  def set_defaults
    initialize_hierarchy
    self.folder = self.hierarchy.default
  end

  def historicize
    self.revision = self.revision.nil? ? 1 : self.revision + 1
    ZHistory.create item: ZItem.find(self.id) unless self.new_record?
  end

  #@jtodoLOW handle the first and last with timestamp because of uuid as id
end
