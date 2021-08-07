describe 'Comments' do
  describe 'Post#create' do
    context '存在しない HorseRace に対して Comment の投稿を行った場合' do
      it '404 エラーとなる' do
        post horse_race_comments_path(horse_race_id: Faker::Number.number)
        expect(response.status).to eq 404
      end
    end
  end
end
