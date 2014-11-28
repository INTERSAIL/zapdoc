class ZHierarchy < ActiveRecord::Base
  attr_accessor :item

  def self.table_name
    ZItem.table_name
  end

  def root
    folder.find_by(z_item_id: nil) || folder.create!(label: root_label)
  end

  def root?
    self.item.folder.nil?
  end

  def folder
    ZFolder
  end


end