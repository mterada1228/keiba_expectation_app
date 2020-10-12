require 'rails_helper'

RSpec.describe 'Races' do
  describe 'Get#index' do
    before { create_list(:race, 5) }

    it 'リクエストに正常に応答できること' do
      get races_path
      expect(response).to be_successful
      expect(response.body).to include 'レース一覧'
    end
  end

  describe 'Get#show' do
    let(:race) { create(:race, race_name: 'アイビスSD') }

    it 'リクエストに正常に応答できること' do
      get race_path(race)
      expect(response).to be_successful
      expect(response.body).to include 'アイビスSD'
    end
  end
end
