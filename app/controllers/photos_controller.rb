class PhotosController < ApplicationController
  PicsPerPage = 9

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

  #upload photo in article
  def uploadinarticle
    photo = Photo.new({
        upload_photo_in_article: params[:photo],
        user_id: @id_login
      })
    photo.save
    render json: {url: photos_getoriginal_path(id: photo.id)}
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
    @page_count = (@user.photos.size / Float(PicsPerPage)).ceil
    @current_page = Integer(params[:page] || 1)
    @could_edit = (@id_login.to_i == params[:id].to_i)

    @photo_columns = {
      'column_1' => [],
      'column_2' => [],
      'column_3' => []
    }
    @user.photos.offset((@current_page - 1) * PicsPerPage).limit(PicsPerPage).each.with_index do |photo, index|
      photo.index_in_page = (@current_page - 1) * PicsPerPage + index
      @photo_columns["column_#{index % 3 + 1}"] << photo
    end

    respond_to do |format|
      format.html
      format.json do
        photo_columns_json = {
          'column_1' => [],
          'column_2' => [],
          'column_3' => []
        }
        @photo_columns.each do |key, photos_in_column|
          photos_in_column.each do |current_photo|
            photo_columns_json[key] << {
              intro: current_photo.intro,
              id: current_photo.id,
              index: current_photo.index_in_page
            }
          end
        end

        render json: {
        couldEdit: @could_edit,
        currentPage: @current_page,
        pageCount: @page_count,
        photoColumns: photo_columns_json
        }
      end
    end
  end

  #get thumbnail photo
  def getthumbnail
    photo = Photo.find(params[:id])
    send_data photo.thumbnail, type: photo.content_type, disposition: 'inline'
  end

  #edit photos' intro and delete photos
  def editanddelete
    intro_edit_hash = ActiveSupport::JSON.decode params[:intro] 
    photo_delete_array = ActiveSupport::JSON.decode params[:delete]
    
    photo_delete_array.each do |photo_id|
      Photo.find(photo_id).destroy
      intro_edit_hash.delete photo_id
    end

    intro_edit_hash.each do |photo_id, intro|
      photo_to_edit = Photo.find(photo_id)
      photo_to_edit.intro = intro
      photo_to_edit.save
    end

    render json: {success: true}
  end
end
