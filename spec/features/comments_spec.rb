feature 'Comments' do
  let(:horse_race) { create(:horse_race) }
  before do
    create_list(:comment, 5, horse_race: horse_race, comment_type: :positive)
    create_list(:comment, 5, horse_race: horse_race, comment_type: :negative)
  end

  feature 'index' do
    scenario '買いコメント一覧を表示する' do
      visit horse_race_comments_path(horse_race, comment_type: :positive)

      expect(page).to have_text('買い コメント一覧')
      expect(page.all('.comment-show-area').count).to eq(5)
    end

    scenario '不安コメント一覧を表示する' do
      visit horse_race_comments_path(horse_race, comment_type: :negative)

      expect(page).to have_text('不安 コメント一覧')
      expect(page.all('.comment-show-area').count).to eq(5)
    end
  end

  feature 'show' do
    let(:parent_comment) { create(:comment, horse_race: horse_race, description: 'sample comment') }

    scenario 'コメント返信ボタンを押す' do
      visit horse_race_comment_path(horse_race, parent_comment)

      expect(page).to have_text(parent_comment.user_name)
      expect(page).to have_text(parent_comment.description)
      expect(page).to have_selector('#comment_user_name')
      expect(page).to have_selector('#comment_description')
    end
  end

  feature 'create' do
    scenario '必要な項目を埋めて投稿を行う' do
      visit horse_race_comments_path(horse_race, comment_type: :positive)

      fill_in 'comment_user_name', with: 'sample user'
      fill_in 'comment_description', with: 'sample comment'
      click_button '投稿する'

      expect(page).to have_text('コメントを投稿しました')
    end

    scenario 'ニックネームは空白で投稿を行う' do
      visit horse_race_comments_path(horse_race, comment_type: :positive)

      fill_in 'comment_description', with: 'sample comment'
      click_button '投稿する'

      expect(page).to have_text('コメントを投稿しました')
    end

    scenario 'コメントを空白で投稿を行う' do
      visit horse_race_comments_path(horse_race, comment_type: :positive)

      fill_in 'comment_user_name', with: 'sample user'
      click_button '投稿する'

      expect(page).to have_text('コメントの投稿に失敗しました。')
      expect(page).to have_text('コメントを入力してください')
    end

    scenario '30文字以上のニックネームを入力して投稿を行う' do
      visit horse_race_comments_path(horse_race, comment_type: :positive)

      fill_in 'comment_user_name', with: 'a' * 30
      fill_in 'comment_description', with: 'sample comment'
      click_button '投稿する'

      expect(page).to have_text('コメントの投稿に失敗しました。')
      expect(page).to have_text('ニックネームは29文字以内で入力してください')
    end

    scenario '1000文字以上のコメントを入力して投稿を行う' do
      visit horse_race_comments_path(horse_race, comment_type: :positive)

      fill_in 'comment_user_name', with: 'sample user'
      fill_in 'comment_description', with: 'a' * 1000
      click_button '投稿する'

      expect(page).to have_text('コメントの投稿に失敗しました。')
      expect(page).to have_text('コメントは999文字以内で入力してください')
    end

    scenario 'HTMLタグを含めたコメントを入力して投稿を行う' do
      visit horse_race_comments_path(horse_race, comment_type: :positive)

      fill_in 'comment_user_name', with: '<h1>sample user</h1>'
      fill_in 'comment_description', with: '<script>function hoge(){};</script>'
      click_button '投稿する'

      expect(page).to have_selector '.card-header', text: 'sample user'
      expect(page).to have_selector '.card-body > p', text: 'function hoge(){};'
    end
  end
end
