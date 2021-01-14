describe RacesHelper do
  describe 'race_condition' do
    context 'side が NULLの場合' do
      let(:race) { create(:race, side: nil) }
      before do
        create_list(:race_regulation, 5, race: race)
      end

      it 'course_type, turn, side は表示されない' do
        race_condition = [I18n.t("enums.race.course_type.#{race.course_type}"),
                          "#{race.distance}m",
                          I18n.t("enums.race.turn.#{race.turn}")
                         ].concat(race.race_regulations.map do |regulation|
                           I18n.t("enums.race_regulation.#{regulation.regulation}")
                         end).reject(&:blank?).join(' ')
        expect(helper.race_condition(race)).to eq(race_condition)
      end
    end
  end
end
