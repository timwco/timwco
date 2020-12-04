class AddPriceToWishlist < ActiveRecord::Migration[6.0]
  def change
    add_column :wishlist_items, :price, :integer, default: 0
  end
end
