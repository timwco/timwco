class Content < ApplicationRecord
  # Validations
  validates :key, presence: true,
                  uniqueness: true,
                  format: { with: /\A[a-z0-9_]+\z/, message: "only lowercase letters, numbers, and underscores" }
  validates :content, presence: true

  # Callbacks
  before_save :render_content_html

  # Class methods
  def self.get(key)
    find_by(key: key)&.rendered_html || ""
  end

  private

  def render_content_html
    return if content.blank?

    # If raw_text is true, skip Markdown and just sanitize plain text
    if raw_text
      self.rendered_html = ActionController::Base.helpers.sanitize(
        content,
        tags: %w[],  # No HTML tags allowed in raw text
        attributes: {}
      )
      return
    end

    # Redcarpet configuration
    options = {
      filter_html: false,
      hard_wrap: true,
      link_attributes: { target: "_blank", rel: "noopener noreferrer" },
      space_after_headers: true,
      prettify: true,
      safe_links_only: false  # Allow all link protocols
    }

    extensions = {
      autolink: true,
      superscript: true,
      fenced_code_blocks: true,
      strikethrough: true,
      tables: true,
      underline: true,
      highlight: true,
      no_intra_emphasis: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    # Render and sanitize with explicit protocol allowlist
    self.rendered_html = ActionController::Base.helpers.sanitize(
      markdown.render(content),
      tags: %w[
        p br h1 h2 h3 h4 h5 h6
        ul ol li
        a
        strong em code pre blockquote
        table thead tbody tr th td
        hr
        img
      ],
      attributes: %w[href target rel src alt title colspan rowspan class]
    )
  end
end
