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
  end
end
