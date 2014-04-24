class User < ActiveRecord::Base
    has_many :blog_articles
    has_many :tags

    validates :username, uniqueness: true
    validates :username, :password, :email, :gender, presence: true
end
