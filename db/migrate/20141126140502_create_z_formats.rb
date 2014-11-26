class CreateZFormats < ActiveRecord::Migration
  def change
    create_table :z_formats do |t|
      t.uuid :id
      t.string :description
      t.string :mime_type
      t.array :accepted_extensions
      t.boolean :default

      t.timestamps
    end
  end
end
