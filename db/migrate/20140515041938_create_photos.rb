class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.text :intro
      t.binary :thumbnail
      t.binary :original
      t.string :content_type

      t.timestamps
    end
  end
end
