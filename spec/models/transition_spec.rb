require 'rails_helper'

RSpec.describe Transition, type: :model do
  describe '譲渡履歴登録' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_recever) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let(:transition) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: user_sender.id, recever_id: user_recever.id) } 
  let(:transition_ticket_blank) { FactoryBot.build(:transition, ticket_id: '', sender_id: user_sender.id, recever_id: user_recever.id) } 
  let(:transition_sender_blank) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: '', recever_id: user_recever.id) } 
  let(:transition_recever_blank) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: user_sender.id, recever_id: '') } 
  let(:transition_recever_myself) { FactoryBot.build(:transition, ticket_id: ticket.id, sender_id: user_sender, recever_id: user_sender) } 
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
      it 'recever_idが空では登録できない' do
        transition_recever_blank.valid?
        expect(transition_recever_blank.errors.full_messages).to include("Recever can't be blank")
      end
      it 'recever_idが自分自身では登録できない' do
        transition_recever_myself.valid?
        expect(transition_recever_myself.errors.full_messages).to include("Recever can't select myself")
      end
    end
  end
end
