require 'rails_helper'

RSpec.describe Race, type: :model do
  let(:race) { FactoryGirl.create(:race)}

  describe 'race_horses_sorted_by_horse_number' do
    let(:race_horse1) { FactoryGirl.create(:race_horse, horse_number: '3')}
    let(:race_horse2) { FactoryGirl.create(:race_horse, horse_number: '5')}
    let(:race_horse3) { FactoryGirl.create(:race_horse, horse_number: '1')}

    it '馬番の昇順でソートされていること' do
      binding.pry
      race_horse = race.race_horses_sorted_by_horse_number

      expected(race_horse[0]).to eq(race_horse3)
      expected(race_horse[0]).to eq(race_horse1)
      expected(race_horse[0]).to eq(race_horse2)
    end
  end
end
