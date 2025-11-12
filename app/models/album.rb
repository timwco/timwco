class Album < ApplicationRecord
  validates :title, presence: true
  validates :spotify_id, presence: true
  validates :order, presence: true
end
