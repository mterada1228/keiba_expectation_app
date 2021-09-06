describe 'Comments' do
  describe 'Post#create' do
    context '存在しない HorseRace に対して Comment の投稿を行った場合' do
      it '404 エラーとなる' do
        post horse_race_comments_path(horse_race_id: Faker::Number.number,
                                      comment_type: 'positive'),
             params: { comment: { user_name: 'test user', description: 'test comment' } }
        expect(response.status).to eq 404
      end
    end

    context '存在しない comment_type を指定して投稿を行った場合' do
      it '400 エラーとなる' do
        post horse_race_comments_path(horse_race_id: Faker::Number.number,
                                      comment_type: 'forbidden')
        expect(response.status).to eq 400
      end
    end
  end
end
