class CreateCollections < ActiveRecord::Migration[8.1]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.integer :collection_type, null: false

      t.timestamps
    end

    add_index :collections, [ :name, :collection_type ], unique: true
  end
end
