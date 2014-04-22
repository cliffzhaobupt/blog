class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :login?

  def login?
    if session[:username]
      @login = true
      @username_login = session[:username]
    else
      @login = false
    end
  end
end
