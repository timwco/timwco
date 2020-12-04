class WishlistItem < ApplicationRecord
  enum category: [:games, :kitchen, :tech, :books, :misc]
  enum price: ["$", "$$", "$$$"]
end