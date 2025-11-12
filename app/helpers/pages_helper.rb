module PagesHelper
  def currently_reading
    currently_reading = Rails.cache.fetch('currently_reading', expires_in: 12.hours) do
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

  def pub_year(book)
    if book['book']['publication_year'].present?
      book['book']['publication_year']
    elsif book['date_added'].present?
      Time.parse(book['date_added']).year
    else
      "Unknown"
    end
  end

  def book_title(book)
    if book['book']['title_without_series'].present?
      book['book']['title_without_series']
    elsif book['book']['title'].present?
      book['book']['title']
    else
      "Unknown"
    end
  end
end
