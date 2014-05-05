class AddUserPhoto < ActiveRecord::Migration
  def change
    add_column :users, :photo, :binary
  end
end
