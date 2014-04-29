class BlogController < ApplicationController
  BlogPerPage = 5

  #get list by user id and page number
  def listbyuser
    @user = User.find(params[:id])
    @username = @user.username
    @title = @username + "'s blog"
    @blog_title = @username + ' の ブログ'

    @has_articles = @user.blog_articles.size > 0
    if @has_articles
      @page_count = (@user.blog_articles.size / Float(BlogPerPage)).ceil
      @current_page = Integer(params[:page] || 1)
      @articles = @user.blog_articles.offset((@current_page - 1) * BlogPerPage).limit(BlogPerPage)  
    end
  end

  #get ariticle detail by ariticle id
  def articledetail
    @article = BlogArticle.find(params[:id])
    @user = @article.user
  end
end
