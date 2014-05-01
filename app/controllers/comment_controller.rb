class CommentController < ApplicationController
  CommentPerPage = 8

  def getcomments
    current_page = Integer(params[:page] || 1)
    article = BlogArticle.find(params[:id])
    page_count = (article.comments.size / Float(CommentPerPage)).ceil
    comments = article.comments.offset((current_page - 1) * CommentPerPage).limit(CommentPerPage)
    comment_arr = []
    comments.each do |comment|
      comment_arr << {
        arid: comment.blog_article_id,
        username: comment.user.username,
        time: comment.created_at,
        content: comment.comment
        } 
    end
    render json: {comments: comment_arr, page_count: page_count}
  end
  
  def addcomment
    
  end
end
