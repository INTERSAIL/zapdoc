class CreateZDocumentInfos < ActiveRecord::Migration
  def up
    create_table :z_document_infos do |t|
      t.string :label
      t.string :revision
      #@jtodoIMP change name here to item_type
      t.string :type
      t.string :format_identifier

      t.timestamps
    end
  end

  def down
    drop_table :z_document_infos
  end
end
