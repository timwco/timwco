class ContentResource < Madmin::Resource
  # Define which attributes to show
  attribute :id, form: false, index: false
  attribute :key, index: true
  attribute :content
  attribute :raw_text
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Don't show rendered_html in forms or index - it's auto-generated
  attribute :rendered_html, form: false, index: false
end