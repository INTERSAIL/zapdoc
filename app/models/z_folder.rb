class ZFolder < ZItem
  has_many :documents, class_name: 'ZDocument', dependent: :destroy
end
