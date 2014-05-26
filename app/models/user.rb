require 'mini_magick'

class User < ActiveRecord::Base
  has_many :blog_articles
  has_many :tags
  has_many :photos
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

  validates :username, uniqueness: true
  validates :username, :password, :email, :gender, presence: true

  def upload_photo=(picture_field)
    image = MiniMagick::Image.read(picture_field.read)
    image.resize '200'
    image.format 'png'
    self.photo = image.to_blob
    image.resize '48'
    self.small_photo = image.to_blob
  end

  def sign_up_date
    self.created_at.localtime.to_date
  end
end
