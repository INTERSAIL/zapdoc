class CreateZDocuments < ActiveRecord::Migration
  def change
    create_table :z_documents do |t|
      t.string :filename

      t.timestamps
    end
  end
end
