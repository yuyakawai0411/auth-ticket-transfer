require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_other) { FactoryBot.create(:user) } 
    context '全てのユーザーを検索する時' do
      subject { get '/v1/users' }
      it 'user,user_otherデータが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(2) 
      end
      it 'userに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(user.id)
        expect(json['data'][0]['nickname']).to eq(user.nickname)
        expect(json['data'][0]['email']).to eq(user.email)
        expect(json['data'][0]['phone_number']).to eq(user.phone_number)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)    
      end
    end
  end

  describe 'GET #show' do
  let!(:user) { FactoryBot.create(:user) } 
  let!(:user_other) { FactoryBot.create(:user) } 
  let(:user_not_exist) { user.id + user_other.id }
    context '存在するユーザーを検索する時' do
      subject { get "/v1/users/#{user.id}" }
      it 'userに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data']['id']).to eq(user.id)
        expect(json['data']['nickname']).to eq(user.nickname)
        expect(json['data']['email']).to eq(user.email)
        expect(json['data']['phone_number']).to eq(user.phone_number)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しないユーザーを検索する時' do
      subject { get "/v1/users/#{user_not_exist}"  }
      it 'エラーメッセージが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('登録されていないユーザーです') 
      end
      it  'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
end
