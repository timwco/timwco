class AlbumResource < Madmin::Resource
  menu parent: "Other Things", position: 4

  # Attributes
  attribute :id, form: false
  attribute :title
  attribute :spotify_id
  attribute :order
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :spotify_data

  # Associations

  # Add scopes to easily filter records
  # scope :published

  # Add actions to the resource's show page
  # member_action do |record|
  #   link_to "Do Something", some_path
  # end

  # Customize the display name of records in the admin area.
  # def self.display_name(record) = record.name

  # Customize the default sort column and direction.
  # def self.default_sort_column = "created_at"
  #
  # def self.default_sort_direction = "desc"
end
