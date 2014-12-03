class ZItemInfo
  #@jtodoIMP the idea is to have a lighter item used to transfer only metadata
  include ActiveModel::Model

  attr_accessor :label, :type, :revision, :created_at

  # def self.from_z_item(item)
  #   if item.respond_to?(:each)
  #     res = []
  #     item.each { |i| res << self.from_z_item(i) }
  #   else
  #     attrs = item.attributes.select { |k,v| self.attribute_names.include?(k) }
  #     res = self.new(attrs)
  #     res.type = item[:_type] || 'ZItem'
  #   end
  #   res
  # end

end
