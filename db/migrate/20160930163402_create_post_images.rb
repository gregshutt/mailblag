class CreatePostImages < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.references :post
      t.string :image
      
      t.timestamps
    end
  end
end
