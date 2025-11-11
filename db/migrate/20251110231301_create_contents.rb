class CreateContents < ActiveRecord::Migration[8.1]
  def change
    create_table :contents do |t|
      t.string :key, null: false
      t.text :content, null: false
      t.text :rendered_html

      t.timestamps
    end

    add_index :contents, :key, unique: true
  end
end
