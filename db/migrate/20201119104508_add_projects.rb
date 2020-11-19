class AddProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.text :outcome
      t.string :started
      t.string :link
      t.text :notes
      t.timestamps
    end    
  end
end
