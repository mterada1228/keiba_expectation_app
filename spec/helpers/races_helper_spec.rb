require 'rails_helper'

describe RacesHelper do
  describe 'race_condition' do
    context 'side が NULLの場合' do
      let(:race) { create(:race, side: nil) }
      let(:race_condition) do
        [I18n.t("enums.race.course_type.#{race.course_type}"),
         "#{race.distance}m",
         I18n.t("enums.race.turn.#{race.turn}"),
         race.regulation1,
         race.regulation2,
         race.regulation3,
         race.regulation4].reject(&:blank?).join(' ')
      end

      it 'course_type, turn, side は表示されない' do
        expect(helper.race_condition(race)).to eq(race_condition)
      end
    end
  end
end
