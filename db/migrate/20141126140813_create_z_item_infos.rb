class CreateZItemInfos < ActiveRecord::Migration
  def up
    create_table :z_item_infos do |t|
      t.string :label
      t.string :identifier
      t.string :revision
      #@jtodoIMP rename because it's reserved for STI
      t.string :type

      t.timestamps
    end
  end

  def down
    drop_table :z_item_infos
  end
end
