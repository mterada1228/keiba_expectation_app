feature 'Races' do
  feature 'Horses' do
    feature 'Comments' do
      let(:race) { create(:race) }
      # TODO: 馬表示機能を実装すれば、idの指定は不要
      let(:horse) { create(:horse, id: 0) }

      feature 'index' do
        scenario '買いコメント一覧を表示する' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :positive)

          expect(page).to have_text('買い コメント一覧')
        end

        scenario '不安コメント一覧を表示する' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :negative)

          expect(page).to have_text('不安 コメント一覧')
        end
      end

      feature 'create' do
        scenario '必要な項目を埋めて投稿を行う' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :positive)

          fill_in 'comment_user_name', with: 'sample user'
          fill_in 'comment_description', with: 'sample comment'
          click_button '投稿する'

          expect(page).to have_text('コメントを投稿しました')
        end

        scenario 'ニックネームは空白で投稿を行う' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :positive)

          fill_in 'comment_description', with: 'sample comment'
          click_button '投稿する'

          expect(page).to have_text('コメントを投稿しました')
        end

        scenario 'コメントを空白で投稿を行う' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :positive)

          fill_in 'comment_user_name', with: 'sample user'
          click_button '投稿する'

          expect(page).to have_text('コメントの投稿に失敗しました。')
          expect(page).to have_text('コメントを入力してください')
        end

        scenario '30文字以上のニックネームを入力して投稿を行う' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :positive)

          fill_in 'comment_user_name', with: 'a' * 30
          fill_in 'comment_description', with: 'sample comment'
          click_button '投稿する'

          expect(page).to have_text('コメントの投稿に失敗しました。')
          expect(page).to have_text('ニックネームは29文字以内で入力してください')
        end

        scenario '1000文字以上のコメントを入力して投稿を行う' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :positive)

          fill_in 'comment_user_name', with: 'sample user'
          fill_in 'comment_description', with: 'a' * 1000
          click_button '投稿する'

          expect(page).to have_text('コメントの投稿に失敗しました。')
          expect(page).to have_text('コメントは999文字以内で入力してください')
        end
      end
    end
  end
end
