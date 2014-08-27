module ZapDoc
   class Folder < Item
    has_many :documents, class_name: 'ZapDoc::Document', dependent: :destroy
  end
end