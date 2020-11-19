class AddActiveToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :active, :boolean, default: false
  end
end
