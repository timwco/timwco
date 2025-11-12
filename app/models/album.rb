class Album < ApplicationRecord
  validates :spotify_id, presence: true
  validate :spotify_data_present

  before_validation :fetch_spotify_data, if: :should_fetch_spotify_data?

  # Helper method to access cached Spotify data
  def album_info
    spotify_data&.deep_symbolize_keys
  end

  # Manually refresh Spotify data
  def refresh_spotify_data!
    fetch_spotify_data
    save!
  end

  private

  # Determine if we should fetch Spotify data
  def should_fetch_spotify_data?
    spotify_id.present? && (spotify_id_changed? || spotify_data.blank?)
  end

  # Fetch data from Spotify API and cache it
  def fetch_spotify_data
    return unless spotify_id.present?

    begin
      service = SpotifyService.new
      self.spotify_data = service.get_album_info(spotify_id)

      # Auto-populate title from Spotify data for convenience
      self.title = spotify_data['title'] if spotify_data.present?
    rescue SpotifyService::SpotifyError => e
      errors.add(:spotify_id, "failed to fetch album data: #{e.message}")
    rescue StandardError => e
      errors.add(:base, "unexpected error fetching Spotify data: #{e.message}")
    end
  end

  # Validate that Spotify data was successfully fetched
  def spotify_data_present
    if spotify_id.present? && spotify_data.blank?
      errors.add(:spotify_data, "could not be fetched from Spotify")
    end
  end
end
