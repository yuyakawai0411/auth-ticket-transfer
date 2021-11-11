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
    end
  end
end
