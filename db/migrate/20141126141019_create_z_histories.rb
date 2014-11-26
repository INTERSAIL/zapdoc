class CreateZHistories < ActiveRecord::Migration
  def change
    create_table :z_histories do |t|
      t.uuid :id
      t.timestamp :history_date
      t.integer :zitem_id
      t.integer :revision

      t.timestamps
    end
  end
end
