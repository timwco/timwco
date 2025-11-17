class CreateWishlistItems < ActiveRecord::Migration[8.1]
  def change
    create_table :wishlist_items do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.integer :price, null: false
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
