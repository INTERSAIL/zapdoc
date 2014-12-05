class CreateZFormats < ActiveRecord::Migration
  def change
    create_table :z_formats, id: :uuid do |t|
      t.string :description
      t.string :mime_type
      t.text :accepted_extensions, array: true, default: []
      t.boolean :default

      t.timestamps
    end
  end
end
