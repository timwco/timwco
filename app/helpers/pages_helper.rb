module PagesHelper
  def currently_reading
    currently_reading = Rails.cache.fetch('last_updated', expires_in: 12.hours) do
      begin
        client = Goodreads.new(api_key: ENV['GOODREADS_API_KEY'] || Rails.application.credentials.goodreads_api_key)
        shelf = client.shelf('67608900', 'currently-reading')
        shelf.books
      rescue => ex
        puts ex
      end
    end
    currently_reading
  end

end
