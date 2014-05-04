class CommentController < ApplicationController
  CommentPerPage = 8

  def getcomments
    current_page = Integer(params[:page] || 1)
    render json: Comment.generate_comment_hash(params[:id], current_page, CommentPerPage)
  end
  
  def new
    puts 'comes here'
    Comment.create({
      comment: params[:content],
      user_id: params[:login_id],
      blog_article_id: params[:article_id]
      })
    render json: Comment.generate_comment_hash(params[:article_id], CommentPerPage)
  end

end
