class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :gender
      t.string :self_intro
      t.integer :popularity, default: 0

      t.timestamps
    end
  end
end
