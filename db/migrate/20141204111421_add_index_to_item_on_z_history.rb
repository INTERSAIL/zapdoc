class AddIndexToItemOnZHistory < ActiveRecord::Migration
  def change
    add_index :z_histories, :z_item_id
  end
end
