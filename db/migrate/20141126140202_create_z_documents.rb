class CreateZDocuments < ActiveRecord::Migration
  def up
      add_column :z_items, :resource_uri, :string
  end

  def down
    remove_column :z_items, :resource_uri, :string
  end
end
