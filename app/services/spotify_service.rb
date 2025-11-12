require 'net/http'
require 'json'
require 'base64'

class SpotifyService
  SPOTIFY_AUTH_URL = 'https://accounts.spotify.com/api/token'
  SPOTIFY_API_BASE = 'https://api.spotify.com/v1'
  TOKEN_CACHE_KEY = 'spotify_access_token'
  TOKEN_EXPIRY_SECONDS = 3300 # 55 minutes (5 min buffer before 1-hour expiry)

  class SpotifyError < StandardError; end
  class AuthenticationError < SpotifyError; end
  class RateLimitError < SpotifyError; end
  class NotFoundError < SpotifyError; end

  def initialize
    @client_id = Rails.application.credentials.spotify_client_id
    @client_secret = Rails.application.credentials.spotify_secret_id

    raise AuthenticationError, 'Spotify credentials not configured' if @client_id.blank? || @client_secret.blank?
  end

  # Public API: Get album information by Spotify album ID
  def get_album(album_id)
    raise ArgumentError, 'Album ID cannot be blank' if album_id.blank?

    access_token = authenticate
    url = "#{SPOTIFY_API_BASE}/albums/#{album_id}?market=US"

    response = make_request(url, {
      'Authorization' => "Bearer #{access_token}"
    })

    JSON.parse(response.body)
  rescue JSON::ParserError => e
    raise SpotifyError, "Failed to parse Spotify response: #{e.message}"
  end

  # Returns formatted album data with essential fields
  def get_album_info(album_id)
    album = get_album(album_id)

    {
      title: album['name'],
      artists: album['artists'].map { |a| a['name'] }.join(', '),
      image_url: album['images']&.first&.dig('url'),
      spotify_url: album['external_urls']['spotify'],
      release_date: album['release_date']
    }
  end

  private

  # Authenticate with Spotify and get access token (cached for 55 minutes)
  def authenticate
    # Check cache first
    cached_token = Rails.cache.read(TOKEN_CACHE_KEY)
    return cached_token if cached_token.present?

    # Get new token
    uri = URI(SPOTIFY_AUTH_URL)
    request = Net::HTTP::Post.new(uri)

    # Base64 encode client_id:client_secret for Basic auth
    credentials = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
    request['Authorization'] = "Basic #{credentials}"
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.set_form_data({ 'grant_type' => 'client_credentials' })

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise AuthenticationError, "Failed to authenticate with Spotify: #{response.code} - #{response.body}"
    end

    data = JSON.parse(response.body)
    access_token = data['access_token']

    # Cache the token
    Rails.cache.write(TOKEN_CACHE_KEY, access_token, expires_in: TOKEN_EXPIRY_SECONDS)

    access_token
  rescue JSON::ParserError => e
    raise AuthenticationError, "Failed to parse authentication response: #{e.message}"
  end

  # Make HTTP request with error handling and retry logic
  def make_request(url, headers = {}, max_retries: 2)
    retries = 0
    auth_retries = 0

    begin
      uri = URI(url)
      request = Net::HTTP::Get.new(uri)

      headers.each { |key, value| request[key] = value }

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, read_timeout: 10) do |http|
        http.request(request)
      end

      case response
      when Net::HTTPSuccess
        response
      when Net::HTTPUnauthorized
        # Token expired, clear cache and retry once
        raise AuthenticationError, "Token expired or invalid"
      when Net::HTTPTooManyRequests
        # Rate limited
        retry_after = response['Retry-After'].to_i
        retry_after = 5 if retry_after.zero? # Default to 5 seconds if not specified
        raise RateLimitError.new("Rate limited, retry after #{retry_after} seconds").tap { |e| e.instance_variable_set(:@retry_after, retry_after) }
      when Net::HTTPNotFound
        raise NotFoundError, "Album not found: #{url}"
      else
        raise SpotifyError, "Spotify API error: #{response.code} - #{response.body}"
      end
    rescue AuthenticationError => e
      if auth_retries < 1
        auth_retries += 1
        Rails.cache.delete(TOKEN_CACHE_KEY)
        headers['Authorization'] = "Bearer #{authenticate}"
        retry
      else
        raise AuthenticationError, "Authentication failed after retry"
      end
    rescue RateLimitError => e
      if retries < max_retries
        retries += 1
        retry_after = e.instance_variable_get(:@retry_after) || 5
        sleep(retry_after)
        retry
      else
        raise RateLimitError, "Rate limit exceeded after #{retries} retries"
      end
    rescue Timeout::Error, Errno::ECONNRESET, Errno::ETIMEDOUT => e
      if retries < max_retries
        retries += 1
        sleep(1)
        retry
      else
        raise SpotifyError, "Network error after #{retries} retries: #{e.message}"
      end
    end
  end
end
