require 'rails_helper'

RSpec.describe "Transitions", type: :request do
  describe 'POST #create' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_receiver) { FactoryBot.create(:user) }
  let(:user_not_exist) { user_sender.id + user_receiver.id }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let(:ticket_not_exist) { ticket.id + 1 }
  let!(:transition) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id, receiver_id: user_receiver.id) }
    context 'チケットの譲渡にて、paramsを正しくリクエストした時' do
      subject { post "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions", params: { receiver_id: user_receiver.id }  }
      it 'transitionモデルのカウントが1増える' do
        expect{
          subject
        }. to change(Transition, :count).by(1)
      end
      it 'transitionに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data']['ticket_id']).to eq(ticket.event.name)
        expect(json['data']['sender_id']).to eq(user_sender.nickname)
        expect(json['data']['receiver_id']).to eq(user_receiver.nickname)
      end
      it 'ticketsテーブルでticketのuser_idがreceiverのidになる' do
        get "/users/#{user_sender.id}/tickets/#{ticket.id}"
        json = JSON.parse(response.body)
        expect(json['data']['user_id']).to eq(user_sender.nickname)
        subject
        get "/users/#{user_receiver.id}/tickets/#{ticket.id}"
        json = JSON.parse(response.body)
        expect(json['data']['user_id']).to eq(user_receiver.nickname) 
      end
      it 'HTTP201が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(201)
      end
    end
    
    context 'チケットの譲渡にて、paramsを正しくリクエストしなかった時' do
      subject { post "/users/#{user_sender.id}/tickets/#{ticket.id}/transitions", params: { receiver_id: user_not_exist }  }
      it 'transitionモデルのカウントが増えない' do
        expect{
          subject
          }. to change(Transition, :count).by(0)
      end
      it 'エラーメッセージが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to include("Receiver doesn't exist") 
      end
      it 'ticketsテーブルでticketのuser_idがsenderのidのままである' do 
        get "/users/#{user_sender.id}/tickets/#{ticket.id}"
        json = JSON.parse(response.body)
        expect(json['data']['user_id']).to eq(user_sender.nickname)
        subject
        get "/users/#{user_sender.id}/tickets/#{ticket.id}"
        json = JSON.parse(response.body)
        expect(json['data']['user_id']).to eq(user_sender.nickname)
      end
      it 'HTTP422が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(422)
      end
    end

    context '所持していないチケットを譲渡しようとした時' do
      subject { post "/users/#{user_sender.id}/tickets/#{ticket_not_exist}/transitions", params:  { receiver_id: user_receiver.id } }
      it 'エラーメッセージが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to include("所持していないチケットです") 
      end
      it 'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end

  describe 'GET #index' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_receiver) { FactoryBot.create(:user) }
  let(:user_not_exist) { user_receiver.id + user_sender.id }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let(:ticket_not_exist) { ticket.id + 1 }
  let!(:transition) { FactoryBot.create(:transition) }
    context 'user_receiverが所持するチケットを検索した時' do
      subject { get "/users/#{transition.ticket.user.id}/tickets/#{transition.ticket.id}/transitions"  }
      it 'transitionが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
      end
      it 'transitionに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(transition.id)
        expect(json['data'][0]['ticket_id']).to eq(transition.ticket.event.name)
        expect(json['data'][0]['sender_id']).to eq(transition.sender.nickname)
        expect(json['data'][0]['receiver_id']).to eq(transition.receiver.nickname)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context 'user_receiverが所持しないチケットを検索した時' do
      subject { get "/users/#{user_receiver.id}/tickets/#{ticket_not_exist}/transitions" }
      it 'エラーメッセージが返される' do 
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('所持していないチケットです') 
      end
      it 'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
  
  describe 'GET #show' do
  let!(:user_sender) { FactoryBot.create(:user) }
  let!(:user_receiver) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user_sender.id) }
  let(:ticket_not_exist) { ticket.id + 1 }
  let!(:transition) { FactoryBot.create(:transition, ticket_id: ticket.id, sender_id: user_sender.id, receiver_id: user_receiver.id) }
  let(:transition_not_exist) { transition.id + 1 }
    context '存在する譲渡履歴を検索した時' do
      subject { get "/users/#{transition.ticket.user.id}/tickets/#{transition.ticket.id}/transitions/#{transition.id}" }
      it 'transitionに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data']['id']).to eq(transition.id)
        expect(json['data']['ticket_id']).to eq(transition.ticket.event.name)
        expect(json['data']['sender_id']).to eq(transition.sender.nickname)
        expect(json['data']['receiver_id']).to eq(transition.receiver.nickname)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しない譲渡履歴を検索した時' do
      subject { get "/users/#{transition.ticket.user.id}/tickets/#{transition.ticket.id}/transitions/#{transition_not_exist}" }
      it 'エラーメッセージが表示される' do 
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('存在しない譲渡履歴です') 
      end
      it 'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404)
      end
    end

    context 'user_receiverが所持しないチケットを検索した時' do
      subject { get "/users/#{user_receiver.id}/tickets/#{ticket_not_exist}/transitions/#{transition.id}" }
      it 'エラーメッセージが返される' do 
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('所持していないチケットです') 
      end
      it 'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
end
