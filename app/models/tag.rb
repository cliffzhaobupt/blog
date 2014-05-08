class Tag < ActiveRecord::Base
    belongs_to :user, counter_cache: true
    has_many :blog_articles
    validates :name, uniqueness: {message: 'already has this tag'}
    validates :name, presence: {message: 'no tag found'}
end