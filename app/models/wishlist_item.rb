class WishlistItem < ApplicationRecord
  enum category: [:games, :kitchen, :tech, :books, :misc, :sports, :lego]
  enum price: ["$", "$$", "$$$"]
end