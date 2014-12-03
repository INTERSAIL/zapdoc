class CreateZItems < ActiveRecord::Migration
  def change
    create_table :z_items, id: :uuid do |t|
      t.string :label
      t.hstore :custom_attributes
      t.text :tags, array: true, default: []
      t.integer :revision
      t.string :format_identifier
      t.string :mime_type
      t.uuid :z_item_id
      # for STI
      t.string :type

      t.timestamps
    end
  end
end
