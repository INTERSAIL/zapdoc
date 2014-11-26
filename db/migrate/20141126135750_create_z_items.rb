class CreateZItems < ActiveRecord::Migration
  def up
    create_table :z_items do |t|
      t.uuid :id
      t.string :label
      t.hstore :custom_attributes
      t.array :tags
      t.integer :revision
      t.string :format_identifier
      t.string :mime_type
      t.integer :folder_id

      t.timestamps
    end
  end

  def down
    drop_table :z_items
  end
end
