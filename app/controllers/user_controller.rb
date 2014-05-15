class UserController < ApplicationController
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

    def photo
        user = User.find(params[:id])
        send_data(user.photo, type: 'image/png', disposition: 'inline')
    end

    def small_photo
        user = User.find(params[:id])
        send_data(user.small_photo, type: 'image/png', disposition: 'inline')
    end
end
