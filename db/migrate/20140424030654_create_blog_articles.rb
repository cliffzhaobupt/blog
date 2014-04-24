class CreateBlogArticles < ActiveRecord::Migration
  def change
    create_table :blog_articles do |t|
      t.string :title
      t.text :article
      t.integer :comment_num
      t.integer :read_num

      t.timestamps
    end
  end
end
