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
    context 'チケット送り先に、存在しないユーザーを選択した時' do
    
    end
    context 'チケット送り先に、自分自身を選択した時' do
    
    end
  end

  describe 'GET #index' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_recever) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let!(:ticket_other) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let!(:transition) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id, recever_id: user_recever.id) }
    context '存在するチケットを検索した時' do
      it 'transition,transition_otherが返される' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions"
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
      end
      it 'transitionに正しい値がある' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions"
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(transition.id)
        expect(json['data'][0]['ticket_id']).to eq(transition.ticket_id)
        expect(json['data'][0]['sender_id']).to eq(transition.sender_id)
        expect(json['data'][0]['recever_id']).to eq(transition.recever_id)
      end
      it 'transition_otherに正しい値がある' do
        # get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions"
        # json = JSON.parse(response.body)
        # expect(json['data'][0]['id']).to eq(transition_other.id)
        # expect(json['data'][0]['ticket_id']).to eq(transition_other.ticket_id)
        # expect(json['data'][0]['sender_id']).to eq(transition_other.sender_id)
        # expect(json['data'][0]['recever_id']).to eq(transition_other.recever_id)
      end
      it 'HTTP200が返される' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end
    context '存在しないチケットを検索した時' do
      it 'エラーメッセージが返される' do 
        # expect(json['data'].length).to eq(0) 
      end
      it 'HTTP404が返される' do
        # expect(json['status']).to eq(200) 
      end
    end
  end
  
  describe 'GET #show' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_recever) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let!(:ticket_other) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let!(:transition) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id, recever_id: user_recever.id) }
    context '存在するトランザクションを検索した時' do
      it 'transitionが返される' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions/#{transition.id}"
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
      end
      it 'transitionに正しい値がある' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions/#{transition.id}"
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(transition.id)
        expect(json['data'][0]['ticket_id']).to eq(transition.ticket_id)
        expect(json['data'][0]['sender_id']).to eq(transition.sender_id)
        expect(json['data'][0]['recever_id']).to eq(transition.recever_id)
      end
      it 'HTTP200が返される' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions/#{transition.id}"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
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
