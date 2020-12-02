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
    it 'リクエストに正常に応答できること' do
      get race_path(race)
      expect(response).to be_successful
    end
  end
end
