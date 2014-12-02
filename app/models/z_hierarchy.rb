class ZHierarchy < ActiveRecord::Base
  attr_accessor :item

  def self.table_name
    ZItem.table_name
  end

  def root
    find_root || new_root
  end

  def root?
    return false unless self.item.is_a? folder_class
    self.item.folder.nil?
  end

  def folder_class
    ZFolder
  end

  def default
    return nil if root?
    find_root || root
  end

  def find_root
    folder_class.find_by folder: nil
  end

  private

  def new_root
    folder_class.create label: folder_class.root_label
  end

  def method_missing(name, *args, &block)
    self.item.send name,args,block
  end
end