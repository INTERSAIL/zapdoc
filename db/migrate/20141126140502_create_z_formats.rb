class CreateZFormats < ActiveRecord::Migration
  def up
    create_table :z_formats do |t|
      t.string :description
      t.string :mime_type
      t.text :accepted_extensions, array: true, default: []
      t.boolean :default

      t.timestamps
    end
  end

  def down
    drop_table :z_formats
  end
end
