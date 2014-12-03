class CreateZHistories < ActiveRecord::Migration
  def change
    create_table :z_histories do |t|
      t.datetime :history_date
      t.uuid :z_item_id
      t.integer :revision

      t.timestamps
    end
  end
end
