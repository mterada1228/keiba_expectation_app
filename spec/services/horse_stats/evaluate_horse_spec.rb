describe HorseStats::EvaluateHorse do
  let(:horse) { create(:horse) }
  let(:race_distance_1000_turf) { create(:race, distance: 1000, course_type: :turf) }
  let(:race_distance_2000_turf) { create(:race, distance: 2000, course_type: :turf) }
  let(:race_distance_1600_dirt) { create(:race, distance: 1600, course_type: :dirt) }
  let(:race_distance_1800_dirt) { create(:race, distance: 1800, course_type: :dirt) }
  let!(:horse_race_distance_1000_turf) do
    create(:horse_race, horse: horse, race: race_distance_1000_turf, time: '00:01:10.4')
  end
  let!(:horse_race_distance_2000_turf) do
    create(:horse_race, horse: horse, race: race_distance_2000_turf, time: '00:02:10.5')
  end
  let!(:horse_race_distance_1600_dirt) do
    create(:horse_race, horse: horse, race: race_distance_1600_dirt, time: '00:01:50.6')
  end
  let!(:horse_race_distance_1800_dirt) do
    create(:horse_race, horse: horse, race: race_distance_1800_dirt, time: '00:02:00.7')
  end

  subject { described_class.new(horse.horse_races).call }

  describe 'call' do
    it '競走馬のコースごとの持ちタイムを表示する' do
      expect(subject.best_times_by_course.times).to eq([
        HorseStats::CourseTime.new(horse_race_distance_1000_turf),
        HorseStats::CourseTime.new(horse_race_distance_2000_turf),
        HorseStats::CourseTime.new(horse_race_distance_1600_dirt),
        HorseStats::CourseTime.new(horse_race_distance_1800_dirt)
      ])
    end
  end
end
