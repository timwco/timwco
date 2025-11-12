class AddSpotifyDataToAlbums < ActiveRecord::Migration[8.1]
  def change
    add_column :albums, :spotify_data, :jsonb
  end
end
