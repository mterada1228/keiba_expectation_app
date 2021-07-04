feature 'Races' do
  feature 'Horses' do
    feature 'PositiveComments' do
      feature 'index' do
        let(:race) { create(:race) }
        let(:horse) { create(:horse) }

        scenario '買いコメント一覧を表示する' do
          visit race_horse_positive_comments_path(race_id: race.id, horse_id: horse.id)

          expect(page).to have_text('買いコメント一覧')
        end
      end
    end
  end
end
