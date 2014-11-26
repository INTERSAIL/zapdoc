class CreateZFolders < ActiveRecord::Migration
  def change
    create_table :z_folders do |t|
      t.boolean :is_root

      t.timestamps
    end
  end
end
