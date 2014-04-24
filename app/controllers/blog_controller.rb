class BlogController < ApplicationController
  def listbyuser
    @user = User.find(params[:id])
    @username = @user.username
    @title = @username + "'s blog"
    @blog_title = @username + ' の ブログ'
  end
end
