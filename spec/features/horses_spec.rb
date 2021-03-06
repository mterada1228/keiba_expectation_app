feature 'Horses' do
  feature 'index' do
    let!(:horses) { create_list(:horse, 5) }

    scenario 'レース一覧を表示する' do
      visit horses_path

      # 全てのレースが画面に表示されていること
      expect(page).to have_selector('tr.horse', count: horses.count)

      # 必要な項目が画面上に表示されていること
      expect(page).to have_text(horses.first.id)
      expect(page).to have_text(horses.first.name)
    end
  end

  feature 'show' do
    let(:horse) { create(:horse) }
    let(:races) { create_list(:race, 3) }
    before do
      races.each do |race|
        create(:horse_race, horse: horse, race: race)
      end
    end

    scenario 'レースページを表示する' do
      visit horse_path(horse)

      # 全てのレース結果が画面に表示されていること
      expect(page).to have_selector('tr.horse_race',
                                    count: horse.horse_races.count)
      # グラフエリア
      expect(page).to have_text(horse.name)
      # レース結果エリア
      expect(page.all('th').map(&:text))
        .to match(%w(日程 レース 枠番 馬番 オッズ 人気 順位 騎手 斤量 タイム 着差 通過順 後半3F 馬体重 増減 賞金))
      result = HorseRace.includes(:race).order('races.start DESC').first
      expect(page.all('.horse_race')[0].all('td').map(&:text))
        .to match([
          result.race.start.to_s(:date),
          result.race.name,
          result.gate_number,
          result.horse_number,
          result.odds,
          result.popularity,
          result.order_of_arrival,
          result.jockey,
          result.burden_weight,
          result.time.try { |time| time.to_s(:min_second_millisecond) },
          result.time_diff,
          result.passing_order,
          result.last_3f,
          result.horse_weight,
          result.difference_in_horse_weight,
          result.get_prize
        ].map(&:to_s))
    end
  end
end
