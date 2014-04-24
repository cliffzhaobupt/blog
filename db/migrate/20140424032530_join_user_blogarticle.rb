class JoinUserBlogarticle < ActiveRecord::Migration
  def change
    add_column :blog_articles, :user_id, :integer
    add_column :users, :blog_articles_count, :integer, default: 0
  end
end
