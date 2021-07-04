feature 'Races' do
  feature 'Horses' do
    feature 'NegativeComments' do
      feature 'index' do
        let(:race) { create(:race) }
        let(:horse) { create(:horse) }

        scenario '不安コメント一覧を表示する' do
          visit race_horse_negative_comments_path(race_id: race.id, horse_id: horse.id)

          expect(page).to have_text('不安コメント一覧')
        end
      end
    end
  end
end
