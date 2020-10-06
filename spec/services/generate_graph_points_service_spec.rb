require 'rails_helper'

RSpec.describe GenerateGraphPointsService do
  let(:horse) { FactoryGirl.create(:horse) }
  let(:race_result) do
    FactoryGirl.create(:race_result, name: 'レース', RPCI: 50, ave_1F: 14)
  end
  let(:instance) { described_class.new(horse) }

  describe 'call' do
    subject { instance.call[0] }

    context '勝ったレースの場合' do
      before do
        FactoryGirl.create(:horse_race_result,
                           horse: horse,
                           race_result: race_result,
                           rank: '1')
      end

      it '黄色のプロットが作成される' do
        is_expected
          .to eq(name: 'レース',
                 data: [[50.0, 14.0]],
                 color: described_class::WON_RACES_COLOR)
      end
    end

    context '0.2秒以内の着差で負けたレースの場合' do
      before do
        FactoryGirl.create(:horse_race_result,
                           horse: horse,
                           race_result: race_result,
                           rank: '2',
                           time_diff: 0.2)
      end

      it '緑色のプロットが作成される' do
        is_expected
          .to eq(name: 'レース',
                 data: [[50.0, 14.0]],
                 color: described_class::RACES_LOST_BY_0_POINT_2_SECONDS_COLOR)
      end
    end

    context '1.0秒以内の着差で負けたレースの場合' do
      before do
        FactoryGirl.create(:horse_race_result,
                           horse: horse,
                           race_result: race_result,
                           rank: '2',
                           time_diff: 1.0)
      end

      it '青色のプロットが作成される' do
        is_expected
          .to eq(name: 'レース',
                 data: [[50.0, 14.0]],
                 color: described_class::RACES_LOST_BY_1_SECOND_COLOR)
      end
    end

    context '1.0秒より大きい着差で負けたレースの場合' do
      before do
        FactoryGirl.create(:horse_race_result,
                           horse: horse,
                           race_result: race_result,
                           rank: '2',
                           time_diff: 1.1)
      end

      it '灰色のプロットが作成される' do
        is_expected
          .to eq(name: 'レース',
                 data: [[50.0, 14.0]],
                 color: described_class::RACES_LOST_BY_MORE_THAN_1_SECOND)
      end
    end
  end
end
