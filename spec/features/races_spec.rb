require 'rails_helper'

feature 'Races' do
  feature 'index' do
    let!(:races) { create_list(:race, 5) }

    scenario 'レース一覧を表示する' do
      visit races_path

      # 全てのレースが画面に表示されていること
      expect(page).to have_selector('tr.race', count: races.count)
      # 必要な項目が画面上に表示されていること
      expect(page).to have_text(races.first.id)
      expect(page).to have_text(races.first.start.to_s(:stamp))
      expect(page).to have_text(races.first.name)
    end
  end

  feature 'show' do
    let(:race) { create(:race, :with_race_horses) }
    let(:race_schedule) do
      [race.start.to_s(:stamp),
       race.day_number,
       race.course,
       race.round].reject(&:blank?).join(' ')
    end
    let(:race_condition) do
      [I18n.t("enums.race.course_type.#{race.course_type}"),
       "#{race.distance}m",
       I18n.t("enums.race.turn.#{race.turn}"),
       I18n.t("enums.race.side.#{race.side}"),
       race.regulation1,
       race.regulation2,
       race.regulation3,
       race.regulation4].reject(&:blank?).join(' ')
    end
    let(:race_prizes) do
      ["#{race.prize1}万",
       "#{race.prize2}万",
       "#{race.prize3}万",
       "#{race.prize4}万",
       "#{race.prize5}万"].join(' ')
    end

    scenario 'レースページを表示する' do
      visit race_path(race)

      # レースに出走する競走馬が全て表示されていること
      expect(page)
        .to have_selector('tr.race_horse', count: race.race_horses.count)
      # 必要な項目が画面上に表示されていること
      expect(page).to have_text(race_schedule)
      expect(page).to have_text(race_condition)
      expect(page).to have_text(race_prizes)
      expect(page).to have_text(race.race_horses.first.gate_number)
      expect(page).to have_text(race.race_horses.first.horse_number)
      expect(page).to have_text(race.horses.first.name)
    end
  end
end
