class AddWishList < ActiveRecord::Migration[6.0]
  def change
    create_table :wishlist_items do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :category
      t.timestamps
    end  
  end
end
