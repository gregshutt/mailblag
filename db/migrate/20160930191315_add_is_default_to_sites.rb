class AddIsDefaultToSites < ActiveRecord::Migration
  def change
    add_column :sites, :is_default, :boolean
  end
end
