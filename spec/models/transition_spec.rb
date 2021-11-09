require 'rails_helper'

RSpec.describe Transition, type: :model do
  describe '譲渡履歴登録' do
  let(:ticket) { FactoryBot.build(:ticket) } 
    context '譲渡履歴登録できるとき' do
      it '必須事項が全て存在すれば登録できる' do
      expect(ticket).to be_valid
      end
    end

    context '譲渡履歴登録できないとき' do
    subject { ticket.errors.full_messages }
      # it 'ticket_idが空では登録できない' do
      #   ticket.ticket_id = ''
      #   ticket.valid?
      #   is_expected.to include 
      # end
      # it 'sender_idが空では登録できない' do
      #   ticket.sender_id = ''
      #   ticket.valid?
      #   is_expected.to include 
      # end
      # it 'recever_idが空では登録できない' do
      #   ticket.recever_id = ''
      #   ticket.valid?
      #   is_expected.to include 
      # end
    end
  end
end
