require 'rails_helper'

describe 'Races' do
  describe 'Get#index' do
    before { create_list(:race, 5) }

    it 'リクエストに正常に応答できること' do
      get races_path
      expect(response).to be_successful
    end
  end

  describe 'Get#show' do
    let(:race) { create(:race, race_name: 'アイビスSD') }

    it 'リクエストに正常に応答できること' do
      get race_path(race)
      expect(response).to be_successful
    end
  end
end
