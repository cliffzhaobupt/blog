class JoinTagUserBlogarticles < ActiveRecord::Migration
  def change
    add_column :tags, :user_id, :integer
    add_column :blog_articles, :tag_id, :integer
    add_column :tags, :blog_articles_count, :integer, default: 0
    add_column :users, :tags_count, :integer, default: 0
  end
end
