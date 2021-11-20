require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  describe 'GET #index' do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_not_exist) { user.id + 1 }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user.id) }
  let!(:ticket_other) { FactoryBot.create(:ticket, user_id: user.id) }
    context '存在するユーザーを検索した時' do
      subject { get "/v1/users/#{user.id}/tickets" }
      it 'ticket,ticket_otherが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(2)
      end
      it 'ticketに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(ticket.id)
        expect(json['data'][0]['name']).to eq(ticket.event.name)
        expect(json['data'][0]['category_id']).to eq(ticket.event.category.name)
        expect(json['data'][0]['status_id']).to eq(ticket.status.name)
        expect(json['data'][0]['user_id']).to eq(ticket.user.nickname)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しないユーザーを検索した時' do
      subject { get "/v1/users/#{user_not_exist}/tickets" }
      it 'エラーメッセージが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('登録されていないユーザーです') 
      end
      it 'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end

  describe 'GET #show' do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_not_exist) { user.id + 1 }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user.id) }
  let!(:ticket_other) { FactoryBot.create(:ticket, user_id: user.id) }
  let(:ticket_not_exist) { ticket.id + ticket_other.id }
    context 'userが所持するチケットを検索した時' do
      subject { get "/v1/users/#{user.id}/tickets/#{ticket.id}" }
      it 'ticketが返され、正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data']['id']).to eq(ticket.id)
        expect(json['data']['name']).to eq(ticket.event.name)
        expect(json['data']['category_id']).to eq(ticket.event.category.name)
        expect(json['data']['status_id']).to eq(ticket.status.name)
        expect(json['data']['user_id']).to eq(ticket.user.nickname)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context 'userが所持しないチケットを検索した時' do
      subject { get "/v1/users/#{user.id}/tickets/#{ticket_not_exist}" }
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

    context '存在しないユーザーを検索した時' do
      subject { get "/v1/users/#{user_not_exist}/tickets/#{ticket.id}" }
      it 'エラーメッセージが返される' do 
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('登録されていないユーザーです') 
      end
      it 'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end

  describe 'POST #create' do
  let!(:event) { FactoryBot.create(:event) }
  let(:event_not_exist) { event.id + 1 }
  let!(:user) { FactoryBot.create(:user) }
  let(:user_not_exist) { user.id + 1 }
  let(:ticket) { FactoryBot.build(:ticket, event_id: event.id, user_id: user.id, status_id: 1) }
    context 'チケットの発券にて、paramsを正しくリクエストした時' do
      subject { post "/v1/events/#{event.id}/tickets", params:  { availability_date: '2022-10-25',  user_id: user.id } }
      it 'Ticketモデルのカウントが+1される' do
        expect{
          subject
        }.to change(Ticket, :count).by(1)
      end
      it 'ticketに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data']['name']).to eq(ticket.event.name)
        expect(json['data']['category_id']).to eq(ticket.event.category.name)
        expect(json['data']['status_id']).to eq(ticket.status.name)
        expect(json['data']['user_id']).to eq(ticket.user.nickname)
      end
      it 'HTTP201が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(201)
      end
    end

    context 'チケットの発券にて、paramsを正しくリクエストしなかった時' do
      subject { post "/v1/events/#{event.id}/tickets", params:  { availability_date: '2022-10-25', user_id: user_not_exist } }
      it 'Ticketモデルのカウントが変化しない' do
        expect{
          subject
        }.to change(Ticket, :count).by(0)
      end
      it 'エラーメッセージが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to include("User doesn't exist") 
      end
      it 'HTTP422が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(422) 
      end
    end

    context '存在しないイベントからチケットを発券しようとした時' do
      subject { post "/v1/events/#{event_not_exist}/tickets", params:  { availability_date: '2022-10-25',  user_id: user.id } }
      it 'エラーメッセージが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to include("登録されていないイベントです") 
      end
      it 'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
end
