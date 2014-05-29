class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
    #create user(post)
    def new
      user = User.new(
        username: params[:username],
        password: params[:password],
        email: params[:email],
        gender: params[:gender],
        self_intro: params[:self_intro],
        upload_photo: params[:upload_photo])
      if user.save
        session[:username] = params[:username]
        session[:userid] = user.id
        render(json: {success: true})
      else
            #Get validates messages by: user.errors.messages
            render(json: user.errors.messages.merge(success: false))
          end
        end

    #user login
    def login
      user = User.where(username: params[:username],
        password: params[:password])
      if user.first
        session[:username] = params[:username]
        session[:userid] = user.first.id
        render(json: {success: true})
      else
        render(json: {
          success: false,
          message: "ログイン失敗。"
          })
      end
    end

    #user logout
    def logout
      session.delete :username
      session.delete :userid
      redirect_to :back
    end

    #user list page
    def index
      @page_count = (User.all.size / 12.0).ceil
      @current_page = Integer(params[:page] || 1)
      @user = {
        'column_1' => [],
        'column_2' => [],
        'column_3' => [],
        'column_4' => []
      }
      User.limit(12).offset((@current_page - 1) * 12).each.with_index do |user, index|
        @user["column_#{index % 4 + 1}"] << user
      end
    end

    #send user's photo
    def photo
      user = User.find(params[:id])
      send_data(user.photo, type: 'image/png', disposition: 'inline')
    end

    #send user's small photo
    def small_photo
      user = User.find(params[:id])
      send_data(user.small_photo, type: 'image/png', disposition: 'inline')
    end

    #generate notification pop-up html code
    def notification
      @user = User.find(params[:id])
      notifications = @user.notifications
      @message_count = notifications.where(notification_type: 'message').size

      message_reply_count_hash = notifications.where(notification_type: 'message_reply').group('item_id').size
      @message_replies = []
      message_reply_count_hash.each do |key, val|
        @message_replies << {
          user_id: key,
          user_name: User.find(key).username,
          replies_count: val
        }
      end

      comment_count_hash = notifications.where(notification_type: 'comment').group('item_id').size
      @comments = []
      comment_count_hash.each do |key, val|
        @comments << {
          article_id: key,
          article_title: BlogArticle.find(key).title,
          comments_count: val
        }
      end

      comment_reply_count_hash = notifications.where(notification_type: 'comment_reply').group('item_id').size
      @comment_replies = []
      comment_reply_count_hash.each do |key, val|
        @comment_replies << {
          article_id: key,
          article_title: BlogArticle.find(key).title,
          replies_count: val
        }
      end

      render 'notification', layout: false
    end

    #clear message notification and redirect to message box page
    def clear_message_notification
      messages_to_del = Notification.where(
        user_id: @id_login,
        notification_type: 'message'
        )
      messages_to_del.destroy_all

      redirect_to messages_list_path(id: @id_login)
    end

    #clear message reply notification
    #and redirect to message box page
    def clear_message_reply_notification
      replies_to_del = Notification.where(
        user_id: @id_login,
        notification_type: 'message_reply',
        item_id: params[:id]
        )

      replies_to_del.destroy_all

      redirect_to messages_list_path(id: params[:id])
    end

    #clear comment notification
    #and redirect to blog article page
    def clear_comment_notification
      comments_to_del = Notification.where(
        user_id: @id_login,
        notification_type: 'comment',
        item_id: params[:id]
        )
      comments_to_del.destroy_all

      redirect_to blogs_articledetail_path(id: params[:id])
    end

    #clear comment reply notification
    #and redirect to blog article page
    def clear_comment_reply_notification
      replies_to_del = Notification.where(
        user_id: @id_login,
        notification_type: 'comment_reply',
        item_id: params[:id]
        )
      replies_to_del.destroy_all

      redirect_to blogs_articledetail_path(id: params[:id])
    end
  end
