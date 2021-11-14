require 'rails_helper'

RSpec.describe Transition, type: :model do
  describe '譲渡履歴登録' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_receiver) { FactoryBot.create(:user) }
  let!(:user_not_exist) { FactoryBot.build(:user) } 
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let(:transition) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: user_sender.id, receiver_id: user_receiver.id) } 
  let(:transition_ticket_blank) { FactoryBot.build(:transition, ticket_id: '', sender_id: user_sender.id, receiver_id: user_receiver.id) } 
  let(:transition_sender_blank) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: '', receiver_id: user_receiver.id) } 
  let(:transition_receiver_blank) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: user_sender.id, receiver_id: '') } 
  let(:transition_receiver_not_exist) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: user_sender.id, receiver_id: user_not_exist.id) } 
  let(:transition_receiver_myself) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: user_sender.id, receiver_id: user_sender.id) } 
    context '譲渡履歴登録できるとき' do
      it '必須事項が全て存在すれば登録できる' do
      expect(transition).to be_valid
      end
    end

    context '譲渡履歴登録できないとき' do
      it 'ticket_idが空では登録できない' do
        transition_ticket_blank.valid?
        expect(transition_ticket_blank.errors.full_messages).to include("Ticket can't be blank")
      end
      it 'sender_idが空では登録できない' do
        transition_sender_blank.valid?
        expect(transition_sender_blank.errors.full_messages).to include("Sender can't be blank")
      end
      it 'receiver_idが空では登録できない' do
        transition_receiver_blank.valid?
        expect(transition_receiver_blank.errors.full_messages).to include("Receiver can't be blank")
      end
      it 'receiver_idがDBに存在しないユーザーでは登録できない' do
        transition_receiver_not_exist.valid?
        expect(transition_receiver_not_exist.errors.full_messages).to include("Receiver doesn't exist")
      end
      it 'receiver_idが自分自身では登録できない' do
        transition_receiver_myself.valid?
        expect(transition_receiver_myself.errors.full_messages).to include("Receiver can't select myself")
      end
    end
  end
end
