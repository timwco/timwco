class AddAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :artist
      t.string :image_slug
      t.string :apple_music_url
      t.string :spotify_url
      t.timestamps
    end      
  end
end
