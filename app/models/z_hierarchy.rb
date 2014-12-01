class ZHierarchy < ActiveRecord::Base
  attr_accessor :item

  def self.table_name
    ZItem.table_name
  end

  def root
    find_root || new_root
  end

  def root?
    return false unless self.item.is_a? folder
    self.item.folder.nil?
  end

  def folder
    ZFolder
  end

  def default
    return nil if root?
    return find_root if find_root
    root
  end

  def find_root
    folder.find_by(z_item_id: nil)
  end

  private

  def new_root
    folder.create!(label: folder.root_label)
  end
end