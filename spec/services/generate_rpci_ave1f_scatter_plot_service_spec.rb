require 'rails_helper'

RSpec.describe GenerateRpciAve1fScatterPlotService do
  let(:horse) { create(:horse) }
  let(:race_result) do
    create(:race_result, name: 'レース', RPCI: 50, ave_1F: 14)
  end
  let(:instance) { described_class.new(horse) }

  describe 'call' do
    subject(:scatter_plots) { instance.call }

    it '競走馬に関連する全てのレース結果のプロットが得られる' do
      create_list(:horse_race_result,
                  5,
                  horse: horse,
                  race_result: race_result)

      expect(scatter_plots.count).to eq(5)
    end

    describe 'それぞれのプロットについてのテスト' do
      let!(:horse_race_result) do
        create(:horse_race_result, trait, horse: horse, race_result: race_result)
      end

      context '勝ったレースの場合' do
        let(:trait) { :won_race }

        it '黄色のプロットが作成される' do
          expect(scatter_plots[0])
            .to eq(name: 'レース',
                   data: [[50.0, 14.0]],
                   color: described_class::WON_RACE_COLOR)
        end
      end

      context '0.2秒以内の着差で負けたレースの場合' do
        let(:trait) { :race_lost_by_0_point_2_seconds }

        it '緑色のプロットが作成される' do
          expect(scatter_plots[0])
            .to eq(name: 'レース',
                   data: [[50.0, 14.0]],
                   color: described_class::RACE_LOST_BY_0_POINT_2_SECONDS_COLOR)
        end
      end

      context '1.0秒以内の着差で負けたレースの場合' do
        let(:trait) { :race_lost_by_1_second }

        it '青色のプロットが作成される' do
          expect(scatter_plots[0])
            .to eq(name: 'レース',
                   data: [[50.0, 14.0]],
                   color: described_class::RACE_LOST_BY_1_SECOND_COLOR)
        end
      end

      context '1.0秒より大きい着差で負けたレースの場合' do
        let(:trait) { :race_lost_by_more_than_1_second }

        it '灰色のプロットが作成される' do
          expect(scatter_plots[0])
            .to eq(name: 'レース',
                   data: [[50.0, 14.0]],
                   color: described_class::RACE_LOST_BY_MORE_THAN_1_SECOND_COLOR)
        end
      end
    end
  end
end
