class AddRawTextToContents < ActiveRecord::Migration[8.1]
  def change
    add_column :contents, :raw_text, :boolean, default: false, null: false
  end
end
