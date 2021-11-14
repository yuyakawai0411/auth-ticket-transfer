require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'チケット取得' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_not_exist) { user.id + 1 } 
  let(:ticket) { FactoryBot.build(:ticket, user_id: user.id) } 
  let(:ticket_not_exist_user) { FactoryBot.build(:ticket, user_id: user_not_exist) }
  let(:ticket_nill_user) { FactoryBot.build(:ticket, user_id: '') }
    context 'チケット取得できるとき' do
      it '必須事項が全て存在すれば取得できる' do
      expect(ticket).to be_valid
      end
    end

    context 'チケット取得できないとき' do
    subject { ticket.errors.full_messages }
      it 'availability_dateが空では取得できない' do
        ticket.availability_date = ''
        ticket.valid?
        is_expected.to include "Availability date can't be blank"
      end
      it 'status_idが空では取得できない' do
        ticket.status_id = ''
        ticket.valid?
        is_expected.to include "Status can't be blank"
      end
      it 'status_idが0以下では取得できない' do
        ticket.status_id = 0
        ticket.valid?
        is_expected.to include "Status must be greater than 0"
      end
      it 'status_idが4以上では取得できない' do
        ticket.status_id = 4
        ticket.valid?
        is_expected.to include "Status must be less than 4"
      end
      it 'user_idが空では取得でkない' do
        ticket_nill_user.valid?
        expect(ticket_nill_user.errors.full_messages).to include "User can't be blank"
      end
      it '存在しないuser_idを指定できない' do
        ticket_not_exist_user.valid?
        expect(ticket_not_exist_user.errors.full_messages).to include "User doesn't exist"
      end
    end
  end
end
