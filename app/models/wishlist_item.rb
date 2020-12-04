class WishlistItem < ApplicationRecord
  enum category: [:games, :kitchen, :tech, :books]
end