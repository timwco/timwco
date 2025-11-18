class SpeakingEvent < ApplicationRecord
  # Associations
  validates :name, presence: true
  validates :url, presence: true
  validates :url, format: {
    with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
    message: "must be a valid URL"
  }, if: -> { url.present? }
end
