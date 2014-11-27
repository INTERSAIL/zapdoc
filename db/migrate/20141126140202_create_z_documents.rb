class CreateZDocuments < ActiveRecord::Migration
  #@jtodoIMP here we use the z_item table do change this soon
  def up
    create_table :z_documents do |t|
      t.string :filename

      t.timestamps
    end
  end

  def down
    drop_table :zdocuments
  end
end
