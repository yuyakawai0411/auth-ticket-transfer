require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
  let(:user) { FactoryBot.build(:user) } 
    context 'ユーザー登録できるとき' do
      it '必須事項が全て存在すれば登録できる' do
      expect(user).to be_valid
      end
    end

    context 'ユーザー登録できないとき' do
    subject { user.errors.full_messages }
      it 'nicknameが空では登録できない' do
        user.nickname = ''
        user.valid?
        is_expected.to include 
      end
      it 'emailが空では登録できない' do
        user.email = ''
        user.valid?
        is_expected.to include 
      end
      it 'passwordが空では登録できない' do
        user.password = ''
        user.valid?
        is_expected.to include 
      end
      it 'phone_numberが空では登録できない' do
        user.phone_number = ''
        user.valid?
        is_expected.to include 
      end
    end
  end
end
