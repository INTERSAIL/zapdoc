class AddIndexToItemOnZItemId < ActiveRecord::Migration
  def change
    add_index :z_items, :z_item_id
  end
end
