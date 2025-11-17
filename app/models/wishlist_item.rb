class WishlistItem < ApplicationRecord
  # Enums
  enum :price, {
    cheap: 0,      # $
    medium: 1,     # $$
    expensive: 2   # $$$
  }, validate: true

  # Associations
  belongs_to :collection

  # Validations
  validates :name, presence: true
  validates :url, presence: true
  validates :price, presence: true
  validates :url, format: {
    with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
    message: "must be a valid URL"
  }, if: -> { url.present? }

  # Helper method to display price as symbols
  def price_display
    case price
    when "cheap" then "$"
    when "medium" then "$$"
    when "expensive" then "$$$"
    end
  end
end
