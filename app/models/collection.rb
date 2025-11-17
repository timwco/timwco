class Collection < ApplicationRecord
  # Enums
  enum :collection_type, {
    tools: 1,
    wishlist: 2
  }, validate: true

  # Associations
  has_many :tools, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :collection_type, presence: true
  validates :name, uniqueness: { scope: :collection_type }
end
