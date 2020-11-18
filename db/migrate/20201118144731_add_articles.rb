class AddArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.datetime :published_at
      t.timestamps
    end
  end
end
