class UpdateProjectStructure < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :status, :integer, default: 0 
    remove_column :projects, :outcome
    rename_column :projects, :active, :featured
    rename_column :projects, :notes, :story
    rename_column :projects, :started, :timeline
    change_column :projects, :description, :string
  end
end
