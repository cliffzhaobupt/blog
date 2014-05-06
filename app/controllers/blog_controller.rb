class BlogController < ApplicationController
  before_action :check_login, only: [:new]
  BlogPerPage = 5

  #get list by user id and page number
  def listbyuser
    @user = User.find(params[:id])

    @has_articles = @user.blog_articles.size > 0
    if @has_articles
      @page_count = (@user.blog_articles.size / Float(BlogPerPage)).ceil
      @current_page = Integer(params[:page] || 1)
      @articles = @user.blog_articles.offset((@current_page - 1) * BlogPerPage).limit(BlogPerPage)  
    end
  end

  #get article detail by ariticle id
  def articledetail
    @article = BlogArticle.find(params[:id])
    @user = @article.user
  end

  def new
    @user = User.find(session[:userid])
  end

  def save
    @user = User.find(session[:userid])

    article = BlogArticle.new({
      article: params[:article][:article],
      tag_id: Integer(params[:article][:tag_id]),
      title: params[:article][:title],
      user_id: @user.id
      })
    if article.save
      redirect_to action: 'articledetail', id: article.id
    else
      render action: 'new', notice: article.error.messages
    end
    
  end

  protected
    def check_login
      unless session.has_key?(:userid)
        redirect_to user_index_path
      end
    end
end
