class CreateZDocuments < ActiveRecord::Migration
  def change
      add_column :z_items, :resource_uri, :string
  end
end
