class CreateSitePasswords < ActiveRecord::Migration
  def change
    create_table :site_passwords do |t|
      t.references :site
      t.string :password
      t.timestamps
    end
  end
end
