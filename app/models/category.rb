class Category < ApplicationRecord
  # Associations
  has_many :posts, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: {
    with: /\A[a-z0-9-]+\z/,
    message: "only lowercase letters, numbers, and hyphens allowed"
  }

  # Use slug for URLs instead of ID
  def to_param
    slug
  end
end
