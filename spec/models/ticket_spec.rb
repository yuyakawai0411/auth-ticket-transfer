require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'チケット取得' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_not_exist) { FactoryBot.build(:user) } 
  let(:ticket) { FactoryBot.build(:ticket, user_id: user.id) } 
  let(:ticket_not_exist_user) { FactoryBot.build(:ticket, user_id: user_not_exist.id) }
  let(:ticket_expired) { FactoryBot.build(:ticket, date: '2021-10-10', user_id: user.id) }
    context 'チケット取得できるとき' do
      it '必須事項が全て存在すれば取得できる' do
      expect(ticket).to be_valid
      end
    end

    context 'チケット取得できないとき' do
    subject { ticket.errors.full_messages }
      it 'availabilty_dateが空では取得できない' do
        ticket.availabilty_date = ''
        ticket.valid?
        is_expected.to include "Availabilty date can't be blank"
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
      it '存在しないuser_idを指定できない' do
        ticket_not_exist_user.valid?
        expect(ticket_not_exist_user.errors.full_messages).to include "User doesn't exist"
      end
    end
  end
end
