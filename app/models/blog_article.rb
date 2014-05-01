class BlogArticle < ActiveRecord::Base
    belongs_to :user, counter_cache: true
    belongs_to :tag, counter_cache: true

    has_many :comments
end
