class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :blog_article, counter_cache: true
end
