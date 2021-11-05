require 'rails_helper'

RSpec.describe "Transitions", type: :request do
  describe 'POST #create' do
    context '自身のチケットを選択した時' do
      it 'transitionモデルのカウントが1増える' do
      
      end
      it 'ticketsテーブルでuserのチケットが削除される' do

      end
      it 'ticketsテーブルでuser_otherのチケットが追加される' do 
      
      end
    end
    
    context '他人のチケットを選択した時' do
      it 'transitionモデルのカウントが変化しない' do
      
      end
      it 'ticketsテーブルでuserのチケットが削除されない' do

      end
      it 'ticketsテーブルでuser_otherのチケットが追加されない' do 
      
      end

    end

    context '存在しないチケットを選択した時' do
      it 'transitionモデルのカウントが変化しない' do
      
      end
      it 'ticketsテーブルでuserのチケットが削除されない' do

      end
      it 'ticketsテーブルでuser_otherのチケットが追加されない' do 
      
      end
    end
  end

  describe 'GET #index' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_recever) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket) }
  let!(:transition) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id, recever_id: user_recever.id) }
  let!(:transition_other) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id) }
    context '存在するチケットを検索した時' do
      before do
      end
      it 'transition,transition_otherが返される' do
      end
      it 'transitionに正しい値がある' do
      end
      it 'transition_otherに正しい値がある' do
      end
      it 'HTTP200が返される' do
      end
    end
    context '存在しないチケットを検索した時' do
      before do
      end
      before do
        # get "/users/#{user_not_exist.id}/tickets"
        # json = JSON.parse(response.body)
      end
        it 'エラーメッセージが返される' do 
          # expect(json['data'].length).to eq(0) 
        end
        it 'HTTP404が返される' do
          # expect(json['status']).to eq(200) 
        end
      end
    end
  end
  
  describe 'GET #show' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_recever) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket) }
  let!(:transition) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id, recever_id: user_recever.id) }
  let!(:transition_other) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id) }
    context '存在するトランザクションを検索した時' do
      before do
      end
      it 'transitionが返される' do
      end
      it 'transitionに正しい値がある' do
      end
      it 'HTTP200が返される' do
      end
    end

    context '存在しないトランザクションを検索した時' do
    before do
    end
      it 'エラーメッセージが表示される' do 
      end
      it 'HTTP404が返される' do
      end
    end
  end

end
