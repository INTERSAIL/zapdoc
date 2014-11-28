class ZHierarchy < ActiveRecord::Base
  attr_accessor :item

  def self.table_name
    ZItem.table_name
  end

  def root
    validate_folder
    find_root || new_root
  end

  def new_root
    folder.create!(label: folder.root_label)
  end

  def find_root
    folder.find_by(z_item_id: nil)
  end

  def root?
    validate_folder
    self.item.folder.nil?
  end

  def validate_folder
    raise ArgumentError, "expected: #{folder.name} as item, got: #{self.item.class}" unless self.item.is_a? folder || self.item.folder.nil?
  end

  def folder
    ZFolder
  end

  def default
    root unless find_root.nil?
    find_root
  end
end