class AddSmallPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :small_photo, :binary
  end
end
