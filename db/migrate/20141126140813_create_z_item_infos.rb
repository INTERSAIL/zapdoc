class CreateZItemInfos < ActiveRecord::Migration
  def change
    create_table :z_item_infos do |t|
      t.uuid :id
      t.string :label
      t.string :identifier
      t.string :revision
      t.string :type

      t.timestamps
    end
  end
end
