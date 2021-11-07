require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_other) { FactoryBot.create(:user) } 
    context '全てのユーザーを検索する時' do
      it 'user,user_otherデータが返される' do
        get '/users'
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(2) 
      end
      it 'userに正しい値がある' do
        get '/users'
        json = JSON.parse(response.body)
        expect(json['data'][0]['nickname']).to eq(user.nickname)
        expect(json['data'][0]['email']).to eq(user.email)
        expect(json['data'][0]['phone_number']).to eq(user.phone_number)
      end
      it 'user_otherに正しい値がある' do
        get '/users'
        json = JSON.parse(response.body)
        expect(json['data'][1]['nickname']).to eq(user_other.nickname)
        expect(json['data'][1]['email']).to eq(user_other.email)
        expect(json['data'][1]['phone_number']).to eq(user_other.phone_number)
      end
      it 'HTTP200が返される' do
        get '/users'
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)    
      end
    end
  end

  describe 'GET #show' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_other) { FactoryBot.create(:user) } 
    context '存在するユーザーを検索する時' do
      it 'userデータが返される' do
        get "/users/#{user.id}"
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
      end
      it 'userに正しい値がある' do
        get "/users/#{user.id}"
        json = JSON.parse(response.body)
        expect(json['data'][0]['nickname']).to eq(user.nickname)
        expect(json['data'][0]['email']).to eq(user.email)
        expect(json['data'][0]['phone_number']).to eq(user.phone_number)
      end
      it 'HTTP200が返される' do
        get "/users/#{user.id}"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しないユーザーを検索する時' do
      it 'エラーメッセージが返される' do
        user_not_exist = user.id + user_other.id
        get "/users/#{user_not_exist}" 
        json = JSON.parse(response.body)
        expect(json['message']).to eq('存在しないユーザーです') 
      end
      it  'HTTP404が返される' do
        user_not_exist = user.id + user_other.id
        get "/users/#{user_not_exist}"
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
end
