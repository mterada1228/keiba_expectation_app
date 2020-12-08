require 'rails_helper'

describe 'Races', type: :request do
  let(:race) { create(:race) }

  describe 'Get#index' do
    it 'リクエストに正常に応答できること' do
      get races_path
      expect(response).to be_successful
    end
  end

  describe 'Get#show' do
    before do
      (1..18).to_a.shuffle.each do |n|
        horse = create(:horse)
        create(:race_horse, horse: horse, race: race, horse_number: n)
      end
    end

    it 'リクエストに正常に応答できること' do
      get race_path(race)
      expect(response).to be_successful
    end

    it 'レースに出走する競走馬が馬番の昇順でソートされていること' do
      get race_path(race)
      # インスタンス変数を取得する
      race_horses = controller.instance_variable_get('@race_horses')
      expect(race_horses.pluck(:horse_number)).to eq((1..18).to_a)
    end
  end
end
