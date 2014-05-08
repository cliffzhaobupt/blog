# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
BlogArticle.delete_all

User.create(
    username: 'cliff',
    password: '666666',
    email: 'zhaotianyu@bupt.edu.cn',
    gender: 'male',
    self_intro: %{ようこそ、ぼくのブログへ。どうぞよろしくお願いします。})

('a'..'z').each.with_index do |name_order, index|
    User.create(
        username: "user_#{name_order}",
        password: '666666',
        email: "user_#{name_order}@gmail.com",
        gender: index % 2 == 0 ? 'male' : 'female',
        self_intro: index % 2 == 0 ? 'ようこそ〜' : 'ようこそ、ぼくのブログへ。どうぞよろしくお願いします。')
end

['日本語', '音楽', 'スポーツ', '映画', '旅行'].each do |tag_name|
    Tag.create(
        name: tag_name,
        user_id: 1)
end

20.times do |num|
    BlogArticle.create(
    title: "流れ星_#{num}",
    article: %{<div>流れ星　ねえ　キミは何を想ってみているの？</div>
<div>見つけた星　今　ボクの中で確かに輝く光</div>
<div>夢に描いてた場所は</div>　
<div>もう夢みたいじゃないけど</div>
<div>窓に映ってるボクらは似ているのかな？</div>
<div>君は何て言うだろうな？
<div>流れ星　ねえ　キミは何を想ってみているの？</div>
<div>見つけた星　今　ボクの中で確かに輝く光</div>
<div>夢に描いてた場所は</div>　
<div>もう夢みたいじゃないけど</div>
<div>窓に映ってるボクらは似ているのかな？</div>
<div>君は何て言うだろうな？
<div>流れ星　ねえ　キミは何を想ってみているの？</div>
<div>見つけた星　今　ボクの中で確かに輝く光</div>
<div>夢に描いてた場所は</div>　
<div>もう夢みたいじゃないけど</div>
<div>窓に映ってるボクらは似ているのかな？</div>
<div>君は何て言うだろうな？
<div>流れ星　ねえ　キミは何を想ってみているの？</div>
<div>見つけた星　今　ボクの中で確かに輝く光</div>
<div>夢に描いてた場所は</div>　
<div>もう夢みたいじゃないけど</div>
<div>窓に映ってるボクらは似ているのかな？</div>
<div>君は何て言うだろうな？</div>},
    user_id: 1,
    tag_id: 2
    )
end

20.times do |num|
    Comment.create(
        comment: "#{num + 1}: What a lovely article",
        user_id: 2,
        blog_article_id: 1
        )
end