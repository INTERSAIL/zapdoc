class ZHierarchy
  attr_accessor :item

  #@jtodoMED here make param mandatory and no hash
  def initialize(args = {})
    self.item = args.fetch(:item)
  end

  def self.table_name
    ZItem.table_name
  end

  def self.root
    self.find_root || self.new_root
  end

  def root?
    return false unless self.item.is_a? folder_class
    self.item.folder.nil?
  end

  def self.folder_class
    ZFolder
  end

  def folder_class
    self.class.folder_class
  end

  def default
    return nil if root?
    self.class.find_root || self.class.root
  end

  #@jtodoLOW make this class method
  #@jtodoLOW create a hierarchy_class and folder_class and put them in ZapDoc configurator container
  def self.find_root
    folder_class.find_by folder: nil
  end

  private

  #@jtodoLOW make class method
  def self.new_root
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