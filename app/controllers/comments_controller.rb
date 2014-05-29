class CommentsController < ApplicationController
  CommentPerPage = 8

  def getcomments
    @current_page = Integer(params[:page] || 1)
    article = BlogArticle.find(params[:id])
    @page_count = (article.comments.size / Float(CommentPerPage)).ceil
    @comments = article.comments.order('created_at DESC')
      .offset((@current_page - 1) * CommentPerPage)
      .limit(CommentPerPage)
    # render json: Comment.generate_comment_hash(params[:id], CommentPerPage, current_page)
    render 'commentlist', layout: false
  end
  
  def new
    Comment.create({
      comment: params[:content],
      user_id: params[:login_id],
      blog_article_id: params[:article_id],
      reply_to_id: params[:reply_to_id]
      })

    @current_page = 1
    article = BlogArticle.find(params[:article_id])
    @page_count = (article.comments.size / Float(CommentPerPage)).ceil
    @comments = article.comments.order('created_at DESC')
      .offset((@current_page - 1) * CommentPerPage)
      .limit(CommentPerPage)
    # render json: Comment.generate_comment_hash(params[:article_id], CommentPerPage)
    render 'commentlist', layout: false
  end

end