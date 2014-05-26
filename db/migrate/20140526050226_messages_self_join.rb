class MessagesSelfJoin < ActiveRecord::Migration
  def change
    add_reference :messages, :reply_to
  end
end
