class AddCommentSelfJoin < ActiveRecord::Migration
  def change
    add_reference :comments, :reply_to
  end
end
