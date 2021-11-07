require 'rails_helper'

RSpec.describe "Tickets", type: :request do

  describe 'GET #index' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user.id) }
  let!(:ticket_other) { FactoryBot.create(:ticket, user_id: user.id) }
    context '存在するユーザーを検索した時' do
      it 'ticket,ticket_otherが返される' do
        get "/users/#{user.id}/tickets"
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(2)
      end
      it 'ticketに正しい値がある' do
        get "/users/#{user.id}/tickets"
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(ticket.id) #idの取得が1ズレる
        expect(json['data'][0]['ticket_name']).to eq(ticket.ticket_name)
        # expect(json['data'][0]['event_date']).to eq(ticket.event_date)
        expect(json['data'][0]['category']).to eq(ticket.category.name)
        expect(json['data'][0]['status']).to eq(ticket.status.name)
      end
      it 'ticket_otherに正しい値がある' do
        get "/users/#{user.id}/tickets"
        json = JSON.parse(response.body)
        expect(json['data'][1]['id']).to eq(ticket_other.id) #idの取得が1ズレる
        expect(json['data'][1]['ticket_name']).to eq(ticket_other.ticket_name)
        # expect(json['data'][1]['event_date']).to eq(ticket_other.event_date)
        expect(json['data'][1]['category']).to eq(ticket_other.category.name)
        expect(json['data'][1]['status']).to eq(ticket_other.status.name)
      end
      it 'HTTP200が返される' do
        get "/users/#{user.id}/tickets"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しないユーザーを検索した時' do
      it 'エラーメッセージが返される' do
        user_not_exist = user.id + 1
        get "/users/#{user_not_exist}/tickets"
        json = JSON.parse(response.body)
        expect(json['message']).to eq('存在しないユーザーです') 
      end
      it 'HTTP404が返される' do
        user_not_exist = user.id + 1
        get "/users/#{user_not_exist}/tickets"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end

  describe 'GET #show' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:ticket) { FactoryBot.create(:ticket, user_id: user.id) }
  let!(:ticket_other) { FactoryBot.create(:ticket, user_id: user.id) }
    context '存在するチケットを検索した時' do
      it 'ticketデータが返される' do
        get "/users/#{user.id}/tickets/#{ticket.id}"
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
      end
      it 'ticketに正しい値がある' do
        get "/users/#{user.id}/tickets/#{ticket.id}"
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(ticket.id) #idの取得が1ズレる
        expect(json['data'][0]['ticket_name']).to eq(ticket.ticket_name)
        # expect(json['data'][0]['event_date']).to eq(ticket.event_date)
        expect(json['data'][0]['category']).to eq(ticket.category.name)
        expect(json['data'][0]['status']).to eq(ticket.status.name)
      end
      it 'HTTP200が返される' do
        get "/users/#{user.id}/tickets/#{ticket.id}"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しないチケットを検索した時' do
      it 'エラーメッセージが返される' do 
        ticket_not_exist = ticket.id + ticket_other.id
        get "/users/#{user.id}/tickets/#{ticket_not_exist}"
        json = JSON.parse(response.body)
        expect(json['message']).to eq('存在しないチケットです') 
      end
      it 'HTTP404が返される' do
        ticket_not_exist = ticket.id + ticket_other.id
        get "/users/#{user.id}/tickets/#{ticket_not_exist}"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
end
