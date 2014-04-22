class User < ActiveRecord::Base
    validates :username, uniqueness: true
    validates :username, :password, :email, :gender, presence: true
end
