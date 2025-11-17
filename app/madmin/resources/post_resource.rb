class PostResource < Madmin::Resource
  menu parent: "Blog", position: 0

  # Attributes
  attribute :id, form: false, index: false
  attribute :title, index: true
  attribute :slug, index: true
  attribute :category, index: true
  attribute :abstract
  attribute :content, field: ContentField
  attribute :published_date, index: true
  attribute :estimated_reading_time, form: false, index: true
  attribute :featured_image, index: false, field: FeaturedImageField
  attribute :created_at, form: false, index: false
  attribute :updated_at, form: false, index: false
  attribute :rendered_html, form: false, index: false

  # Customize the display name of records
  def self.display_name(record)
    record.title
  end

  # Customize the default sort column and direction
  def self.default_sort_column
    "published_date"
  end

  def self.default_sort_direction
    "desc"
  end
end
