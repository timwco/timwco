class CategoryResource < Madmin::Resource
  # Attributes
  attribute :id, form: false, index: false
  attribute :name, index: true
  attribute :slug, index: true
  attribute :description
  attribute :created_at, form: false, index: false
  attribute :updated_at, form: false, index: false

  # Customize the display name of records
  def self.display_name(record)
    record.name
  end

  # Customize the default sort column and direction
  def self.default_sort_column
    "name"
  end

  def self.default_sort_direction
    "asc"
  end
end
