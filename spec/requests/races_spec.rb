require 'rails_helper'

describe 'Races' do
  describe 'Get#index' do
    before do
      (0..4).each do |n|
        create(:race, race_name: "race_name_#{n}")
      end
    end

    it 'リクエストに正常に応答できること' do
      get races_path
      expect(response).to be_successful
      (0..4).each do |n|
        expect(response.body).to include("race_name_#{n}")
      end
    end
  end

  describe 'Get#show' do
    let(:race) { create(:race) }
    let(:race_schedule) do
      [race.race_date,
       race.days,
       race.start_time,
       race.race_cource,
       race.round].reject(&:blank?).join(' ')
    end
    let(:race_condition) do
      [I18n.t("enums.race.cource_type.#{race[:cource_type]}"),
       "#{race.distance}m",
       I18n.t("enums.race.turn.#{race[:turn]}"),
       I18n.t("enums.race.side.#{race[:side]}"),
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

    it 'リクエストに正常に応答できること' do
      get race_path(race)
      expect(response).to be_successful

      # 必要な項目が画面上に表示されていること
      expect(response.body).to include(race_schedule)
      expect(response.body).to include(race_condition)
      expect(response.body).to include(race_prizes)
    end
  end
end
