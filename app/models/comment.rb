class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog_article, counter_cache: true

  belongs_to :reply_to, class_name: 'Comment'

  def time_shown_in_webpage
    self.created_at.localtime.to_formatted_s(:db)
  end

  def self.generate_comment_hash article_id, comment_per_page, current_page = 1
    article = BlogArticle.find(article_id)
    page_count = (article.comments.size / Float(comment_per_page)).ceil
    comments = article.comments.order('created_at DESC').offset((current_page - 1) * comment_per_page).limit(comment_per_page)
    comment_arr = []
    comments.each do |comment|
      comment_arr << {
        userid: comment.user.id,
        username: comment.user.username,
        time: comment.created_at.localtime.to_formatted_s(:db),
        content: comment.comment
        }
    end
    {comments: comment_arr, page_count: page_count}
  end

end
