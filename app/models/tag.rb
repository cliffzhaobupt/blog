class Tag < ActiveRecord::Base
    belongs_to :user, counter_cache: true
    has_many :blog_articles
end
