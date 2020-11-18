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

    markdown.render(text).html_safe
  end

  def internal_pages
    pages = [
      { slug: 'about', display: 'About' },
      { slug: 'articles', display: 'Articles' },
      { slug: 'projects', display: 'Projects' },
      { slug: 'tools', display: 'Tools' }
    ]

    html = ""
    pages.each do |page| 
      html += "<a href='/#{page[:slug]}' class='underlined"
      html += request.path_info.include?(page[:slug]) ? " current'" : "'"
      html += ">#{page[:display]}</a>"
    end

    html.html_safe
  end

end
