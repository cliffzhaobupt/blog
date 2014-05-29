class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.string :notification_type
      t.integer :item_id
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
