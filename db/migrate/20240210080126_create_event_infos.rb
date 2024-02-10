class CreateEventInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :event_infos do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :group_id, null: false
      t.timestamps
    end
  end
end
