class CreateZFolders < ActiveRecord::Migration
  def up
    create_table :z_folders do |t|
      t.boolean :is_root

      t.timestamps
    end
  end

  def down
    drop_table :z_folders
  end

end
