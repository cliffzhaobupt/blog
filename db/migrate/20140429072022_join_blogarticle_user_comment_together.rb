class JoinBlogarticleUserCommentTogether < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :blog_article_id, :integer
    remove_column :blog_articles, :comment_num, :integer
    add_column :blog_articles, :comments_count, :integer, default: 0
    remove_column :blog_articles, :read_num, :integer
    add_column :blog_articles, :read_count, :integer, default: 0
  end
end
