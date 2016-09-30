class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.boolean :require_password
      t.string :title

      t.timestamps
    end
  end
end
