class Collection < ApplicationRecord
  # Enums
  enum :collection_type, {
    links: 0,
    tools: 1,
    wishlist: 2
  }, validate: true

  # Associations
  has_many :links, dependent: :destroy
  has_many :tools, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :collection_type, presence: true
  validates :name, uniqueness: { scope: :collection_type }
end
