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
    gender: 'mail',
    self_intro: %{ようこそ、ぼくのブログへ。どうぞよろしくお願いします。})

['日本語', '音楽', 'スポーツ', '映画', '旅行'].each do |tag_name|
    Tag.create(
        name: tag_name,
        user_id: 1)
end

10.times do
    BlogArticle.create(
    title: '流れ星',
    article: %{流れ星　ねえ　キミは何を想ってみているの？
見つけた星　今　ボクの中で確かに輝く光
夢に描いてた場所は　
もう夢みたいじゃないけど
窓に映ってるボクらは似ているのかな？
君は何て言うだろうな？},
    comment_num: 3,
    read_num: 10,
    user_id: 1,
    tag_id: 2
    )
end