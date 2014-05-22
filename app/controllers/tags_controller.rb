class TagsController < ApplicationController
  def get
    begin
      user = User.find(params[:id])
      tags = user.tags
      render json: {success: true, tags: tags}
    rescue ActiveRecord::RecordNotFound
      render json: {success: false}
    end
  end

  def add
    begin
      user = User.find(params[:id])
      new_tag = Tag.new(name: params[:name])
      if new_tag.save
        user.tags << new_tag
      end
      render json: {success: true, tags: user.tags}
    rescue ActiveRecord::RecordNotFound
      render json: {success: false}
    end
  end
end
