class CreateZDocumentInfos < ActiveRecord::Migration
  def change
    create_table :z_document_infos do |t|
      t.string :label
      t.string :revision
      t.string :type
      t.string :format_identifier

      t.timestamps
    end
  end
end
