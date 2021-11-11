require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'チケット取得' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_not_exist) { FactoryBot.build(:user) } 
  let(:ticket) { FactoryBot.build(:ticket, user_id: user.id) } 
  let(:ticket_not_exist_user) { FactoryBot.build(:ticket, user_id: user_not_exist.id) }
  let(:ticket_expired) { FactoryBot.build(:ticket, event_date: '2021-10-10', user_id: user.id) }
    context 'チケット取得できるとき' do
      it '必須事項が全て存在すれば取得できる' do
      expect(ticket).to be_valid
      end
    end

    context 'チケット取得できないとき' do
    subject { ticket.errors.full_messages }
      it 'ticket_nameが空では取得できない' do
        ticket.ticket_name = ''
        ticket.valid?
        is_expected.to include "Ticket name can't be blank"
      end
      it 'event_dateが空では取得できない' do
        ticket.event_date = ''
        ticket.valid?
        is_expected.to include "Event date can't be blank"
      end
      it 'category_idが空では取得できない' do
        ticket.category_id = ''
        ticket.valid?
        is_expected.to include "Category can't be blank"
      end
      it 'category_idが0以下では取得できない' do
        ticket.category_id = 0
        ticket.valid?
        is_expected.to include "Category must be greater than 0"
      end
      it 'category_idが6以上では取得できない' do
        ticket.category_id = 6
        ticket.valid?
        is_expected.to include "Category must be less than 6"
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
      it '本日以前のevent_dateは指定できない' do
        ticket_expired.valid?
        expect(ticket_expired.errors.full_messages).to include "Event date doesn't before today"
      end
      it '存在しないuser_idを指定できない' do
        ticket_not_exist_user.valid?
        expect(ticket_not_exist_user.errors.full_messages).to include "User doesn't exist"
      end
    end
  end
end
