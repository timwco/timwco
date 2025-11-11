module MarkdownHelper
  def render_content(key)
    content = Content.find_by(key: key)
    return "" unless content

    # Wrap markdown content in a div for easier styling (but not raw text)
    if content.raw_text
      content.rendered_html.html_safe
    else
      "<div class=\"content\">#{content.rendered_html}</div>".html_safe
    end
  end

  # For on-demand rendering if needed
  def markdown(text)
    return "" if text.blank?

    options = {
      filter_html: false,
      hard_wrap: true,
      link_attributes: { target: "_blank", rel: "noopener noreferrer" },
      space_after_headers: true
    }

    extensions = {
      autolink: true,
      fenced_code_blocks: true,
      strikethrough: true,
      tables: true,
      underline: true,
      highlight: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown_renderer = Redcarpet::Markdown.new(renderer, extensions)

    sanitize(markdown_renderer.render(text))
  end
end
