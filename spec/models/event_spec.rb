require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryBot.build(:event) } 
  context 'イベント登録できるとき' do
    it '必須事項が全て存在すれば登録できる' do
    expect(event).to be_valid
    end
  end

  context 'イベント登録できないとき' do
  subject { event.errors.full_messages }
    it 'nameが空では登録できない' do
      event.name = ''
      event.valid?
      is_expected.to include "Name can't be blank"
    end
    it 'ownerが空では登録できない' do
      event.owner = ''
      event.valid?
      is_expected.to include "Owner can't be blank"
    end
    it 'dateが空では取得できない' do
      event.date = ''
      event.valid?
      is_expected.to include "Date can't be blank"
    end
    it 'category_idが空では取得できない' do
      event.category_id = ''
      event.valid?
      is_expected.to include "Category can't be blank"
    end
    it 'category_idが0以下では取得できない' do
      event.category_id = 0
      event.valid?
      is_expected.to include "Category must be greater than 0"
    end
    it 'category_idが6以上では取得できない' do
      event.category_id = 6
      event.valid?
      is_expected.to include "Category must be less than 6"
    end
  end
end
