require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    let(:horse) { create(:horse) }
    let(:race) { create(:race) }

    describe 'description' do
      context '入力されていない場合' do
        let(:comment) { build(:comment, horse: horse, race: race, description: nil) }
        it '保存に失敗する' do
          expect(comment).to be_invalid
          expect(comment.errors.full_messages).to include('コメントを入力してください')
        end
      end

      context '1000文字以上の場合' do
        let(:comment) do
          build(:comment, horse: horse, race: race, description: Faker::String.random(length: 1000))
        end

        it '保存に失敗する' do
          expect(comment).to be_invalid
          expect(comment.errors.full_messages).to include('コメントは999文字以内で入力してください')
        end
      end
    end

    describe 'user_name' do
      context '30文字以上の場合' do
        let(:comment) do
          build(:comment, horse: horse, race: race, user_name: Faker::String.random(length: 30))
        end

        it '保存に失敗する' do
          expect(comment).to be_invalid
          expect(comment.errors.full_messages).to include('ニックネームは29文字以内で入力してください')
        end
      end
    end
  end
end
