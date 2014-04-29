class BlogController < ApplicationController
  def listbyuser
    @user = User.find(params[:id])
    @username = @user.username
    @title = @username + "'s blog"
    @blog_title = @username + ' の ブログ'

    @page_count = (@user.blog_articles.size / 5.0).ceil
    @current_page = Integer(params[:page] || 1)
    @articles = @user.blog_articles.offset((@current_page - 1) * 5).limit(5)
  end
end
