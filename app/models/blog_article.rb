class BlogArticle < ActiveRecord::Base
    belongs_to :user, counter_cache: true
    belongs_to :tag, counter_cache: true

    has_many :comments, dependent: :destroy

    validates :title, :article, :tag_id, presence: {message: '未完成な部分がございますけど。'}

    def created_at_normalized
        self.created_at.localtime.to_formatted_s(:db)
    end
end
