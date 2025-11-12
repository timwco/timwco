class CreateAlbums < ActiveRecord::Migration[8.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :spotify_id
      t.integer :order
      t.timestamps
    end
  end
end
