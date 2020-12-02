require 'rails_helper'

describe Race, type: :model do
  let(:race) { create(:race) }
  let(:horse1) { create(:horse) }
  let(:horse2) { create(:horse) }
  let(:horse3) { create(:horse) }

  describe 'race_horses_sorted_by_horse_number' do
    let!(:race_horse1) { create(:race_horse, race: race, horse: horse1, horse_number: 3) }
    let!(:race_horse2) { create(:race_horse, race: race, horse: horse2, horse_number: 5) }
    let!(:race_horse3) { create(:race_horse, race: race, horse: horse3, horse_number: 1) }

    it '馬番の昇順でソートされていること' do
      race_horses = race.race_horses_sorted_by_horse_number

      aggregate_failures do
        expect(race_horses[0].horse_number).to eq(1)
        expect(race_horses[1].horse_number).to eq(3)
        expect(race_horses[2].horse_number).to eq(5)
      end
    end
  end
end
