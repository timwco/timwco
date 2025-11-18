class CustomMarkdownRenderer < Redcarpet::Render::HTML
  # Override the image rendering method to handle asset file lookups and custom classes
  # @param link [String] The image source (could be a URL or filename)
  # @param title [String] The image title attribute (can contain classes)
  # @param alt_text [String] The image alt text
  # @return [String] HTML img tag
  def image(link, title, alt_text)
    # Extract classes from title if it starts with a dot (class syntax)
    # Usage: ![Alt](image.jpg ".rounded-lg .shadow-xl")
    classes = []
    actual_title = title

    if title.present? && title.start_with?(".")
      # Title contains classes, extract them
      classes = title.scan(/\.[\w-]+/).map { |c| c.sub(".", "") }
      actual_title = nil # Don't use title attribute if it was classes
    end

    # Check if this looks like a simple filename (no protocol, no path)
    # e.g., "image.jpg" instead of "http://example.com/image.jpg" or "/path/to/image.jpg"
    if link.present? && !link.match?(%r{^https?://}) && !link.start_with?("/")
      # Try to find a Asset record by filename
      asset = Asset.find_by_filename(link)

      if asset&.file&.attached?
        # Use optimized medium variant for content images
        link = asset.medium_url || asset.url
      end
      # If no asset found, fall through to use the original link
      # This allows external images or references to work as fallback
    end

    # Build the img tag with proper attributes
    class_attr = classes.any? ? %( class="#{classes.join(' ')}") : ""
    title_attr = actual_title.present? ? %( title="#{escape_html(actual_title)}") : ""
    alt_attr = alt_text.present? ? %( alt="#{escape_html(alt_text)}") : ' alt=""'

    %(<img src="#{escape_html(link)}"#{alt_attr}#{title_attr}#{class_attr} loading="lazy">)
  end

  private

  # Escape HTML entities to prevent XSS
  def escape_html(text)
    return "" if text.nil?
    text.to_s.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;").gsub('"', "&quot;")
  end
end
