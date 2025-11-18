class Asset < ApplicationRecord
  has_one_attached :file
  has_many :posts, foreign_key: :featured_image_id, dependent: :nullify

  validates :title, presence: true
  validates :filename, presence: true, uniqueness: true
  validate :file_attached

  # Return the URL for the attached file
  def url
    return nil unless file.attached?
    Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
  end

  # Return a thumbnail variant (for grid views)
  def thumbnail_url
    return nil unless file.attached? && file.image?
    Rails.application.routes.url_helpers.rails_representation_url(
      file.variant(resize_to_limit: [ 600, 400 ]),
      only_path: true
    )
  end

  # Return a medium variant (for single post hero images)
  def medium_url
    return nil unless file.attached? && file.image?
    Rails.application.routes.url_helpers.rails_representation_url(
      file.variant(resize_to_limit: [ 1200, 800 ]),
      only_path: true
    )
  end

  # Class method to find asset by filename
  def self.find_by_filename(filename)
    find_by(filename: filename)
  end

  private

  def file_attached
    errors.add(:file, "must be attached") unless file.attached?
  end
end
