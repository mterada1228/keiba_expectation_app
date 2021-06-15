describe HorseStats::EvaluateHorse do
  let(:horse) { create(:horse) }
  let(:race_distance_1000_turf) { create(:race, distance: 1000, course_type: :turf) }
  let(:race_distance_2000_turf) { create(:race, distance: 2000, course_type: :turf) }
  let(:race_distance_1600_dirt) { create(:race, distance: 1600, course_type: :dirt) }
  let(:race_distance_1800_dirt) { create(:race, distance: 1800, course_type: :dirt) }

  before do
    create(:horse_race, horse: horse, race: race_distance_1000_turf, time: '00:01:10.0')
    create(:horse_race, horse: horse, race: race_distance_2000_turf, time: '00:02:10.0')
    create(:horse_race, horse: horse, race: race_distance_1600_dirt, time: '00:01:50.0')
    create(:horse_race, horse: horse, race: race_distance_1800_dirt, time: '00:02:00.0')
  end

  describe 'call' do
    it '競走馬のコースごとの持ちタイムを表示する' do
      best_times = described_class.new(horse.horse_races).call.best_times_by_course.best_times
      expect(best_times.first)
        .to have_attributes(distance: 1000, course_type: 'turf', time: '1:10.0')
      expect(best_times.second)
        .to have_attributes(distance: 2000, course_type: 'turf', time: '2:10.0')
      expect(best_times.third)
        .to have_attributes(distance: 1600, course_type: 'dirt', time: '1:50.0')
      expect(best_times.fourth)
        .to have_attributes(distance: 1800, course_type: 'dirt', time: '2:00.0')
    end
  end
end
