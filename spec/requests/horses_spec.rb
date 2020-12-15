describe 'Horses' do
  let(:horse) { create(:horse) }

  describe 'Get#index' do
    it 'リクエストに正常に応答できること' do
      get horses_path
      expect(response).to be_successful
    end
  end

  describe 'Get#show' do
    it 'リクエストに正常に応答できること' do
      get horse_path(horse)
      expect(response).to be_successful
    end
  end
end
