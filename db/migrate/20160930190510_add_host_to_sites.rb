class AddHostToSites < ActiveRecord::Migration
  def change
    add_column :sites, :hostname, :string
  end
end
