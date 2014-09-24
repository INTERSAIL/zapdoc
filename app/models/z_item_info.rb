class ZItemInfo
  include ActiveModel::Model
  include CreateAttributes

  create_attributes :label, :identifier, :revision, :created_at, :type, :format_identifier, :mime_type

  def self.from_z_item(item)
    if item.respond_to?(:each)
      res = []
      item.each { |i| res << ZItemInfo.from_z_item(i) }
    else
      attrs = item.attributes.select { |k,v| self.attribute_names.include?(k) }
      res = ZItemInfo.new(attrs)
      res.type = item[:_type] || 'ZItem'
    end
    res
  end
end