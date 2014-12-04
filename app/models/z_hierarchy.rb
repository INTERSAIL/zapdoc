class ZHierarchy
  include ActiveModel::Model

  attr_accessor :item

  #@jtodoMED use intialize with static param

  def self.table_name
    ZItem.table_name
  end

  #@jtodoLOW make class method
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

  #@jtodoLOW make this class method
  #@jtodoLOW create a hierarchy_class and folder_class and put them in ZapDoc configurator container
  def find_root
    folder_class.find_by folder: nil
  end

  private

  #@jtodoLOW make class method
  def new_root
    folder_class.create label: folder_class.root_label
  end

  #@deprecated
  # def method_missing(method_name, *args, &block)
  #   self.item.send method_name,args,&block
  # end
  #
  # def respond_to_missing?(method_name, include_private = false)
  #   self.respond_to? method_name, include_private || super
  # end
end