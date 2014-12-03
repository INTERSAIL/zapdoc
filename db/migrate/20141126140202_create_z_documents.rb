class CreateZDocuments < ActiveRecord::Migration
  #@jtodoMED use change and remove down
  def up
      add_column :z_items, :resource_uri, :string
  end

  def down
    remove_column :z_items, :resource_uri, :string
  end
end
