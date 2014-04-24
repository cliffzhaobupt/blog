module BlogHelper
    def judge_gender gender_db
        {'male' => '男性', 'female' => '女性'}[gender_db]
    end
end
