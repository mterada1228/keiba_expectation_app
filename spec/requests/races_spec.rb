describe 'Races' do
  let(:race) { create(:race) }

  describe 'Get#show' do
    before do
      (1..18).to_a.shuffle.each do |n|
        horse = create(:horse)
        create(:horse_race, horse: horse, race: race, horse_number: n)
      end
    end

    it 'レースに出走する競走馬が馬番の昇順でソートされていること' do
      get race_path(race)
      # インスタンス変数を取得する
      horse_races = controller.instance_variable_get('@horse_races')

      expect(response).to be_successful
      expect(horse_races.pluck(:horse_number)).to eq((1..18).to_a)
    end
  end
end
