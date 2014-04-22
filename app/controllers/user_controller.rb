class UserController < ApplicationController
    #create user(post)
    def new
        user = User.new(
            username: params[:username],
            password: params[:password],
            email: params[:email],
            gender: params[:gender])
        if user.save
            session[:username] = params[:username]
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
        session[:username] = nil
        render(json: {success: true})
    end
end
