class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :abstract
      t.text :content, null: false
      t.text :rendered_html
      t.date :published_date
      t.string :slug, null: false
      t.integer :estimated_reading_time
      t.references :featured_image, foreign_key: { to_table: :assets }

      t.timestamps
    end

    add_index :posts, :slug, unique: true
    add_index :posts, :published_date
  end
end
