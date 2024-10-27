class WishlistItem < ApplicationRecord
  enum category: [:games, :kitchen, :tech, :books, :misc, :sports, :lego, :music]
  enum price: ["$", "$$", "$$$"]
end