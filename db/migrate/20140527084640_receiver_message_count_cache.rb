class ReceiverMessageCountCache < ActiveRecord::Migration
  def change
    add_column :users, :received_messages_count, :integer
  end
end
