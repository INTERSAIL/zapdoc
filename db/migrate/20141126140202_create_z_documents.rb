class CreateZDocuments < ActiveRecord::Migration
  def up
      add_column :z_items, :filename, :string
  end

  def down
    remove_column :z_items, :filename, :string
  end
end
