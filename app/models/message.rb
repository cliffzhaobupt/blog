class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User", counter_cache: :received_messages_count
  belongs_to :reply_to, class_name: "Message"

  def time_shown_in_webpage
    self.created_at.localtime.to_formatted_s(:db)
  end
end
