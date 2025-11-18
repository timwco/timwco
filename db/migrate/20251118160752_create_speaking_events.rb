class CreateSpeakingEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :speaking_events do |t|
      t.string :name
      t.string :url
      t.string :event_name
      t.datetime :event_date
      t.timestamps
    end
  end
end
