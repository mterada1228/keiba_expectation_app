feature 'Races' do
  feature 'index' do
    let!(:races) { create_list(:race, 5) }

    scenario 'レース一覧を表示する' do
      visit races_path

      # 全てのレースが画面に表示されていること
      expect(page).to have_selector('tr.race', count: races.count)
      # 必要な項目が画面上に表示されていること
      expect(page).to have_text(races.first.id)
      expect(page).to have_text(races.first.start.to_s(:date_hour_min))
      expect(page).to have_text(races.first.name)
    end
  end

  feature 'show' do
    let(:race) { create(:race, :with_horse_races) }
    before do
      create_list(:race_prize, 5, race: race)
      create_list(:race_regulation, 5, race: race)
    end

    scenario 'レースページを表示する' do
      visit race_path(race)

      # レースに出走する競走馬が全て表示されていること
      expect(page)
        .to have_selector('tr.horse_race', count: race.horse_races.count)

      # 必要な項目が画面上に表示されていること
      race_schedule = [race.start.to_s(:date_hour_min),
                       "#{race.day_number}日目",
                       I18n.t("enums.race.course.#{race.course}"),
                       "#{race.round}R"].reject(&:blank?).join(' ')
      race_condition = [I18n.t("enums.race.course_type.#{race.course_type}"),
                        "#{race.distance}m",
                        I18n.t("enums.race.turn.#{race.turn}"),
                        I18n.t("enums.race.side.#{race.side}")
                       ].concat(race.race_regulations.map do |regulation|
                         I18n.t("enums.race_regulation.#{regulation.regulation}")
                       end).reject(&:blank?).join(' ')
      race_prizes = race.race_prizes.map { |prize| "#{prize.prize}万" }.join(' ')

      expect(page).to have_text(race_schedule)
      expect(page).to have_text(race_condition)
      expect(page).to have_text(race_prizes)
      expect(page).to have_text(race.horse_races.first.gate_number)
      expect(page).to have_text(race.horse_races.first.horse_number)
      expect(page).to have_text(race.horses.first.name)
    end
  end
end
