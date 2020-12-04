module ApplicationHelper

  def markdown(text)
    extensions = {
      autolink:           true,
      superscript:        true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true
    }

    options = {
      hard_wrap: true,
      link_attributes: { target: '_blank' }
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    text.gsub!(/https?:[\/|.|\w|\s|-]*\.(?:jpg|gif|png)/, '/image-not-found.jpg')
    markdown.render(text).html_safe
  end

  def internal_pages
    pages = [
      { slug: 'about', display: 'About' },
      { slug: 'articles', display: 'Articles' },
      { slug: 'projects', display: 'Projects' },
      # { slug: 'tools', display: 'Tools' }
    ]

    html = ""
    pages.each do |page| 
      html += "<a href='/#{page[:slug]}' class='underlined"
      html += request.path_info.include?(page[:slug]) ? " current'" : "'"
      html += ">#{page[:display]}</a>"
    end

    html.html_safe
  end

  def currently_reading
    currently_reading = Rails.cache.fetch('last_updated', expires_in: 12.hours) do
      begin
        client = Goodreads.new(api_key: ENV['GOODREADS_API_KEY'])
        shelf = client.shelf('67608900', 'currently-reading')
        shelf.books
      rescue => ex
        puts ex
      end
    end
    currently_reading
  end

end
