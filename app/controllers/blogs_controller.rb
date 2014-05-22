class BlogsController < ApplicationController
  before_action :check_login, only: [:new]
  BlogPerPage = 5

  #get list by user id and page number
  def listbyuser
    begin
      @user = User.find(params[:id])
    rescue Exception
      redirect_to users_index_url
      return
    end
    @user.popularity += 1
    @user.save

    @has_articles = @user.blog_articles.size > 0
    if @has_articles
      @page_count = (@user.blog_articles.size / Float(BlogPerPage)).ceil
      @current_page = Integer(params[:page] || 1)
      @articles = @user.blog_articles.order('created_at DESC').offset((@current_page - 1) * BlogPerPage).limit(BlogPerPage)
      @could_edit = (params[:id].to_i == session[:userid].to_i)
    end
  end

  #get article detail by article id
  def articledetail
    @article = BlogArticle.find(params[:id])
    @user = @article.user
    @article.read_count += 1
    @article.save
    @could_edit = (@user.id == session[:userid])
  end

  #new blog article
  def new
    @user = User.find(session[:userid])
  end

  #save new blog article
  def save
    @user = User.find(session[:userid])

    article = @user.blog_articles.create({
      article: params[:article][:article],
      tag_id: 
        params[:article][:tag_id].to_i == 0 ? 
          nil : params[:article][:tag_id].to_i,
      title: params[:article][:title]
      })
    if article.valid?
      redirect_to action: 'articledetail', id: article.id
    else
      redirect_to action: 'new'
    end
  end

  #delete blog article
  def delete
    if params[:userid].to_i == session[:userid].to_i
      article = BlogArticle.find(params[:articleid])
      article.destroy
    end
    redirect_to blogs_listbyuser_path(id: params[:userid])
  end

  #edit blog
  def edit
    @article = BlogArticle.find(params[:id])
    @user = @article.user
  end

  #update blog
  def update
    @article = BlogArticle.find(params[:id])
    if @article.update({
      article: params[:blog_article][:article],
      tag_id: 
        params[:blog_article][:tag_id].to_i == 0 ? 
          nil : params[:blog_article][:tag_id].to_i,
      title: params[:blog_article][:title]
      })
      redirect_to action: 'articledetail', id: params[:id]
    else
      redirect_to action: 'edit', id: params[:id]
    end
  end

  #blog list by tag id
  def listbytag
    @tag = Tag.find(params[:id])
    @user = @tag.user

    @has_articles = @tag.blog_articles.size > 0
    if @has_articles
      @current_page = Integer(params[:page] || 1)
      @page_count = (@tag.blog_articles.size / Float(BlogPerPage)).ceil
      @articles = @tag.blog_articles.order('created_at DESC').offset((@current_page - 1) * BlogPerPage).limit(BlogPerPage)
      @could_edit = (@user.id == session[:userid].to_i)
    end
  end

  protected
    def check_login
      unless session.has_key?(:userid)
        redirect_to users_index_path
      end
    end
end
