class ZItemInfo
  include ActiveModel::Model
  include CreateAttributes

  create_attributes :label, :identifier, :revision, :created_at, :type, :format_identifier, :mime_type

  def self.from_z_item(item)
    if item.respond_to?(:each)
      res = []
      item.each { |i| res << ZItemInfo.from_z_item(i) }
    else
      res = ZItemInfo.new(item.attributes.slice(self.attribute_names))
      res.type = item[:_type] || 'ZItem'
    end
    res
  end
end