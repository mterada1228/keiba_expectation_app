describe Comment do
  let(:horse_race) { create(:horse_race) }

  describe 'validation' do
    context '正常系' do
      let(:comment) { create(:comment, horse_race: horse_race) }

      it '保存に成功する' do
        expect(comment).to be_valid
      end
    end

    describe 'description' do
      context '入力されていない場合' do
        let(:comment) { build(:comment, horse_race: horse_race, description: nil) }
        it '保存に失敗する' do
          expect(comment).to be_invalid
          expect(comment.errors.full_messages).to include('コメントを入力してください')
        end
      end

      context '1000文字以上の場合' do
        let(:comment) do
          build(:comment, horse_race: horse_race, description: Faker::String.random(length: 1000))
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
          build(:comment, horse_race: horse_race, user_name: Faker::String.random(length: 30))
        end

        it '保存に失敗する' do
          expect(comment).to be_invalid
          expect(comment.errors.full_messages).to include('ニックネームは29文字以内で入力してください')
        end
      end
    end
  end

  describe 'convert_user_name_from_blank_to_nil' do
    let(:comment) { build(:comment, horse_race: horse_race, user_name: user_name) }

    subject { comment.save }

    context 'user_name が 空文字の場合' do
      let(:user_name) { '' }

      it 'nil に変換されて保存される' do
        subject
        expect(comment.reload.user_name).to be_nil
      end
    end

    context 'user_name が 空文字ではない場合' do
      let(:user_name) { Faker::Name.name }

      it 'nil に変換されず、そのまま保存される' do
        subject
        expect(comment.reload.user_name).to eq(user_name)
      end
    end
  end
end
