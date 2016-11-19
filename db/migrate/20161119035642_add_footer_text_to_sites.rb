class AddFooterTextToSites < ActiveRecord::Migration
  def change
    add_column :sites, :footer_text, :text
  end
end
