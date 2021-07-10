feature 'Races' do
  feature 'Horses' do
    feature 'Comments' do
      feature 'index' do
        let(:race) { create(:race) }
        let(:horse) { create(:horse) }

        scenario '買いコメント一覧を表示する' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :positive)

          expect(page).to have_text('買い コメント一覧')
        end

        scenario '不安コメント一覧を表示する' do
          visit race_horse_comments_path(race_id: race.id, horse_id: horse.id, position: :negative)

          expect(page).to have_text('不安 コメント一覧')
        end
      end
    end
  end
end
