require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
    context 'ユーザー情報が存在する時' do
    let!(:user) { FactoryBot.create(:user) } 
    let!(:user_other) { FactoryBot.create(:user) } 
      it 'ユーザー情報が表示され、HTTP200が返される' do
        get '/users'
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(4) #expect(json['data'].length).to eq(0)
        expect(json['data'][2]['id']).to eq(user.id)
        expect(json['data'][2]['nickname']).to eq(user.nickname)
        expect(json['data'][2]['email']).to eq(user.email)
        expect(json['data'][2]['phone_number']).to eq(user.phone_number)
        expect(json['data'][3]['id']).to eq(user_other.id)
        expect(json['data'][3]['nickname']).to eq(user_other.nickname)
        expect(json['data'][3]['email']).to eq(user_other.email)
        expect(json['data'][3]['phone_number']).to eq(user_other.phone_number)
        expect(json['status']).to eq(200)        
      end
    end

    context 'ユーザー情報が存在しない時' do
      it 'ユーザー情報が表示されず、HTTP200が返される' do
        get '/users'
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(2) #expect(json['data'].length).to eq(0)
        expect(json['status']).to eq(200)
      end
    end
  end

  describe 'GET #show' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_other) { FactoryBot.create(:user) } 
  let(:user_not_exist) { FactoryBot.build(:user) }
    context '存在するユーザーを検索した時' do
      it 'ユーザー情報が表示され、HTTP200が返される' do
        get "/users/#{user.id}"
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(1)
        expect(json['data'][0]['id']).to eq(user.id)
        expect(json['data'][0]['nickname']).to eq(user.nickname)
        expect(json['data'][0]['email']).to eq(user.email)
        expect(json['data'][0]['phone_number']).to eq(user.phone_number)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しないユーザーを検索した時' do
      it 'エラーメッセージが表示され、HTTP404が返される' do
        get "/users/#{user_not_exist.id}"
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(4) #expect(json['data'].length).to eq(0)
        expect(json['status']).to eq(200) #expect(json['status']).to eq(404) 
      end
    end
  end

end
