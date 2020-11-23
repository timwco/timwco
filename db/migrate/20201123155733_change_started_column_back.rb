class ChangeStartedColumnBack < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :timeline, :started
  end
end
