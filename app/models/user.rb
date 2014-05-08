class User < ActiveRecord::Base
    has_many :blog_articles
    has_many :tags

    validates :username, uniqueness: true
    validates :username, :password, :email, :gender, presence: true

    def sign_up_date
        self.created_at.localtime.to_date
    end
end
