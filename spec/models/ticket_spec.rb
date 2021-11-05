require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'チケット取得' do
  let(:ticket) { FactoryBot.build(:ticket) } 
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
        is_expected.to include 
      end
      it 'event_dateが空では取得できない' do
        ticket.event_date = ''
        ticket.valid?
        is_expected.to include 
      end
      it 'category_idが空では取得できない' do
        ticket.category_id = ''
        ticket.valid?
        is_expected.to include 
      end
      it 'category_idが0以下では取得できない' do
        ticket.category_id = ''
        ticket.valid?
        is_expected.to include 
      end
      it 'category_idが6以上では取得できない' do
        ticket.category_id = ''
        ticket.valid?
        is_expected.to include 
      end
      it 'status_idが空では取得できない' do
        ticket.status_id = ''
        ticket.valid?
        is_expected.to include 
      end
      it 'status_idが0以下では取得できない' do
        ticket.status_id = ''
        ticket.valid?
        is_expected.to include 
      end
      it 'status_idが4以上では取得できない' do
        ticket.status_id = ''
        ticket.valid?
        is_expected.to include 
      end
      it 'user_idが空では取得できない' do
        ticket.user_id = ''
        ticket.valid?
        is_expected.to include 
      end
    end
  end
end
