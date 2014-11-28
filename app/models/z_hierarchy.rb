class ZHierarchy < ActiveRecord::Base
  attr_accessor :item

  def self.table_name
    ZItem.table_name
  end

  def root?
    self.item.folder.nil?
  end

  def folder
    ZFolder.new
  end


end