class CreateTools < ActiveRecord::Migration[8.1]
  def change
    create_table :tools do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.text :description
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
