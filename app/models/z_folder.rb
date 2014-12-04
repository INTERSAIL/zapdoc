class ZFolder < ZItem
  #custom validators
  class UniqueRootValidator < ActiveModel::Validator

    def validate(record)
      hierarchy = ZHierarchy.new item: record
      record.errors[:folder] << 'Cannot have two root folders' if hierarchy.class.find_root && hierarchy.root?
    end
  end

  #relations
  has_many :folders, class_name: :ZFolder, foreign_key: :z_item_id
  has_many :documents, class_name: :ZDocument, foreign_key: :z_item_id
  has_many :items, class_name: :ZItem, foreign_key: :z_item_id

  #validation
  validates_with UniqueRootValidator

  def self.root_label
    'ROOT'
  end

  def root
    self.hierarchy.class.root
  end

  def root?
    self.hierarchy.root?
  end
end
