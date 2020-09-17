require 'rails_helper'

RSpec.describe Race, type: :model do
  let(:race) { FactoryGirl.create(:race) }
  let(:horse1) { FactoryGirl.create(:horse) }
  let(:horse2) { FactoryGirl.create(:horse) }
  let(:horse3) { FactoryGirl.create(:horse) }

  describe 'race_horses_sorted_by_horse_number' do
    let!(:race_horse1) { FactoryGirl.create(:race_horse, race: race, horse: horse1, horse_number: '3') }
    let!(:race_horse2) { FactoryGirl.create(:race_horse, race: race, horse: horse2, horse_number: '5') }
    let!(:race_horse3) { FactoryGirl.create(:race_horse, race: race, horse: horse3, horse_number: '1') }

    it '馬番の昇順でソートされていること' do
      race_horses = race.race_horses_sorted_by_horse_number

      expect(race_horses[0]).to eq(race_horse3)
      expect(race_horses[1]).to eq(race_horse1)
      expect(race_horses[2]).to eq(race_horse2)
    end
  end
end
