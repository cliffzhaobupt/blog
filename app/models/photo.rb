require 'mini_magick'

class Photo < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  def upload_photo=(photo_field)
    image = MiniMagick::Image.read(photo_field.read)
    image.resize '900>'
    self.original = image.to_blob
    image.resize '160'
    self.thumbnail = image.to_blob
    self.intro = photo_field.original_filename
    self.content_type = photo_field.content_type.chomp
  end
end