class PhotoController < ApplicationController
  #redirect to the new photo upload page
  def new
    if session.has_key?(:userid)
      @user = User.find(session[:userid])
    else
      redirect_to users_index_path
    end
  end

  #upload photo
  def upload
    if session.has_key?(:userid)
      @user = User.find(session[:userid])
      jsonResponse = {just_add: []}
      params[:photos].each do |key, val|
        unless val.class.to_s == "String"
          photo = Photo.new({
            upload_photo: val,
            user_id: session[:userid]
            })
          if photo.save
            jsonResponse[:just_add] << {
              id: photo.id,
              intro: photo.intro
            }
          else
            render json: jsonResponse.merge({success: false})
            return
          end
        end
      end
      render json: jsonResponse.merge({success: true})
    else
      redirect_to users_index_path
    end
  end

  #get original photo
  def getoriginal
    photo = Photo.find(params[:id])
    send_data photo.original, type: photo.content_type, disposition: 'inline'
  end

  #update the introduction of uploaded photos
  def updateintro
    if session.has_key?(:userid)
      params[:intros].each do |key, val|
        photo = Photo.find(key.to_i)
        photo.intro = val
        photo.save
      end
      redirect_to action: 'list', id: session[:userid]
    else
      redirect_to users_index_path
    end
  end

  #photo list of a certain user
  def list
    @user = User.find(params[:id])
    @photo_columns = {
      'column_1' => [],
      'column_2' => [],
      'column_3' => []
    }
    @user.photos.each.with_index do |photo, index|
      @photo_columns["column_#{index % 3 + 1}"] << photo
    end
  end

  #get thumbnail photo
  def getthumbnail
    photo = Photo.find(params[:id])
    send_data photo.thumbnail, type: photo.content_type, disposition: 'inline'
  end
end
