class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog_article, counter_cache: true

  def self.generate_comment_hash article_id, *current_page, comment_per_page
    article = BlogArticle.find(article_id)
    page_count = (article.comments.size / Float(comment_per_page)).ceil
    comments = article.comments.offset(((current_page[0] || page_count || 1) - 1) * comment_per_page).limit(comment_per_page)
    comment_arr = []
    comments.each do |comment|
      comment_arr << {
        arid: comment.blog_article_id,
        username: comment.user.username,
        time: comment.created_at.localtime.to_formatted_s(:db),
        content: comment.comment
        } 
    end
    {comments: comment_arr, page_count: page_count}
  end

end
