class Post < ApplicationRecord
  # Associations
  belongs_to :featured_image, class_name: 'Asset', optional: true

  # Validations
  validates :title, :content, :slug, presence: true
  validates :slug, uniqueness: true, format: {
    with: /\A[a-z0-9-]+\z/,
    message: "only lowercase letters, numbers, and hyphens allowed"
  }

  # Callbacks
  before_validation :render_content_html
  before_validation :calculate_reading_time

  # Scopes
  scope :published, -> { where('published_date <= ?', Date.today).where.not(published_date: nil) }
  default_scope { order(published_date: :desc, created_at: :desc) }

  # Override featured_image setter to handle form values (string IDs or objects)
  def featured_image=(value)
    if value.is_a?(String)
      # Form sends string IDs - set the foreign key directly
      self.featured_image_id = value.presence
    else
      # Asset object or nil - use normal assignment
      super(value)
    end
  end

  private

  # Render markdown content to HTML
  def render_content_html
    return if content.blank?

    # Redcarpet configuration (same as Content model)
    options = {
      filter_html: false,
      hard_wrap: true,
      link_attributes: { target: "_blank", rel: "noopener noreferrer" },
      space_after_headers: true,
      prettify: true,
      safe_links_only: false
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

    renderer = CustomMarkdownRenderer.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    # Render and sanitize
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

  # Calculate estimated reading time based on word count
  def calculate_reading_time
    return if content.blank?

    word_count = content.to_s.split.size
    self.estimated_reading_time = (word_count / 200.0).ceil
  end
end
