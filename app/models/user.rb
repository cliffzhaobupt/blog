require 'mini_magick'

class User < ActiveRecord::Base
    has_many :blog_articles
    has_many :tags

    validates :username, uniqueness: true
    validates :username, :password, :email, :gender, presence: true

    def upload_photo=(picture_field)
        image = MiniMagick::Image.read(picture_field.read)
        image.resize '200'
        image.format 'png'
        self.photo = image.to_blob
    end

    def sign_up_date
        self.created_at.localtime.to_date
    end
end
