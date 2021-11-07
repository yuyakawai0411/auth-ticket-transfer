require 'rails_helper'

RSpec.describe "Transitions", type: :request do
  describe 'POST #create' do
    context 'senderに存在するユーザーを選択した時' do
      it 'ticketsテーブルでticketのuser_idがsenderのidである' do

      end
      it 'transitionモデルのカウントが1増える' do
      
      end
      it 'transitionに正しい値がある' do
      
      end
      it 'ticketsテーブルでticketのuser_idがreceverのidになる' do 
      
      end
    end
    
    context 'senderに存在しないユーザーを選択した時' do
      it 'ticketsテーブルでticketのuser_idがsenderのidである' do

      end
      it 'transitionモデルのカウントが増えない' do
      
      end
      it 'エラーメッセージが返される' do
      
      end
      it 'ticketsテーブルでticketのuser_idがsenderのidである' do 
      
      end
    end

    context 'senderに自分自身を選択した時' do
      it 'ticketsテーブルでticketのuser_idがsenderのidである' do

      end
      it 'transitionモデルのカウントが増えない' do
      
      end
      it 'エラーメッセージが返される' do
      
      end
      it 'ticketsテーブルでticketのuser_idがsenderのidである' do 
      
      end
    end
  end

  describe 'GET #index' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_recever) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let!(:transition) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id, recever_id: user_recever.id) }
    context 'user_receverが保有するチケットを検索した時' do
      it 'transitionが返される' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions" #user_receverに変更したい
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
      end
      it 'transitionに正しい値がある' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions" #user_receverに変更したい
        json = JSON.parse(response.body)
        expect(json['data'][0]['ticket_id']).to eq(transition.ticket_id)
        expect(json['data'][0]['sender_id']).to eq(transition.sender_id)
        expect(json['data'][0]['recever_id']).to eq(transition.recever_id)
      end
      it 'HTTP200が返される' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions" #user_receverに変更したい
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context 'user_receverが保有しないチケットを検索した時' do
      it 'エラーメッセージが返される' do 
        ticket_not_exist = ticket.id + 1
        get "/users/#{user_recever.id}/tickets/#{ticket_not_exist}/transitions" 
        json = JSON.parse(response.body)
        expect(json['message']).to eq('存在しないチケットです') 
      end
      it 'HTTP404が返される' do
        ticket_not_exist = ticket.id + 1
        get "/users/#{user_recever.id}/tickets/#{ticket_not_exist}/transitions" 
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end

    context '存在しないユーザーを検索した時' do
      it 'エラーメッセージが返される' do 
        user_not_exist = user_recever.id + 1
        get "/users/#{user_not_exist}/tickets/#{ticket.id}/transitions"
        json = JSON.parse(response.body)
        expect(json['message']).to eq('存在しないユーザーです') 
      end
      it 'HTTP404が返される' do
        user_not_exist = user_recever.id + 1
        get "/users/#{user_not_exist}/tickets/#{ticket.id}/transitions"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
  
  describe 'GET #show' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_recever) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
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
      it 'エラーメッセージが表示される' do 
      end
      it 'HTTP404が返される' do
      end
    end
  end

end
