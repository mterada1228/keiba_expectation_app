describe HorseStats::BestTimesByCourse do
  let(:horse) { create(:horse) }

  subject { described_class.new(horse_races: horse.horse_races) }

  context '同じ距離、同じコースタイプにレースに複数回出走している場合' do
    let(:race1) { create(:race, distance: 1000, course_type: :turf) }
    let(:race2) { create(:race, distance: 1000, course_type: :turf) }
    let!(:horse_race_record_fastest_time) do
      create(:horse_race, horse: horse, race: race1, time: '00:01:10.1')
    end

    before do
      create(:horse_race, horse: horse, race: race2, time: '00:01:10.2')
    end

    it '最も早いタイムのみが取得できる' do
      expect(subject.times.first.time).to eq(horse_race_record_fastest_time.time)
    end
  end

  context '同じ距離だが、コースタイプの違うレースに出走している場合' do
    let(:race1) { create(:race, distance: 1000, course_type: :hundle_race) }
    let(:race2) { create(:race, distance: 1000, course_type: :dirt) }
    let(:race3) { create(:race, distance: 1000, course_type: :turf) }

    before do
      create(:horse_race, horse: horse, race: race1, time: '00:01:10.1')
      create(:horse_race, horse: horse, race: race2, time: '00:01:10.1')
      create(:horse_race, horse: horse, race: race3, time: '00:01:10.1')
    end

    it '全てのタイムが別の要素として取得できる' do
      expect(subject.times.size).to eq(3)
    end

    it '芝 => ダート => 障害の順番で取得できること' do
      expect(subject.times.map(&:course_type)).to match %w[turf dirt hundle_race]
    end
  end

  context '同じコースタイプだが、距離の違うレースに出走している場合' do
    let(:race1) { create(:race, distance: 2000, course_type: :turf) }
    let(:race2) { create(:race, distance: 1000, course_type: :turf) }
    let(:race3) { create(:race, distance: 3000, course_type: :turf) }

    before do
      create(:horse_race, horse: horse, race: race1, time: '00:01:10.1')
      create(:horse_race, horse: horse, race: race2, time: '00:01:10.1')
      create(:horse_race, horse: horse, race: race3, time: '00:01:10.1')
    end

    it '全てのタイムが別の要素として取得できる' do
      expect(subject.times.size).to eq(3)
    end

    it '距離の短い順番で取得できること' do
      expect(subject.times.map(&:distance)).to match [1000, 2000, 3000]
    end
  end
end
