class CreateAssets < ActiveRecord::Migration[8.1]
  def change
    create_table :assets do |t|
      t.string :title, null: false
      t.string :filename, null: false

      t.timestamps
    end

    add_index :assets, :filename, unique: true
  end
end
