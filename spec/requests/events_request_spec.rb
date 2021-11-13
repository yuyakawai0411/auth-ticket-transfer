require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe 'GET #index' do
  let!(:event) { FactoryBot.create(:event) } 
  let!(:event_other) { FactoryBot.create(:event) } 
    context '全てのイベントを検索する時' do
      subject { get '/events' }
      it 'event,event_otherデータが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'].length).to eq(2) 
      end
      it 'eventに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data'][0]['id']).to eq(event.id)
        expect(json['data'][0]['name']).to eq(event.name)
        expect(json['data'][0]['owner']).to eq(event.owner)
        expect(json['data'][0]['category_id']).to eq(event.category.name)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)    
      end
    end
  end

  describe 'GET #show' do
  let!(:event) { FactoryBot.create(:event) } 
  let!(:event_other) { FactoryBot.create(:event) } 
  let(:event_not_exist) { event.id + event_other.id }
    context '存在するイベントを検索する時' do
      subject { get "/events/#{event.id}" }
      it 'eventに正しい値がある' do
        subject
        json = JSON.parse(response.body)
        expect(json['data']['id']).to eq(event.id)
        expect(json['data']['name']).to eq(event.name)
        expect(json['data']['owner']).to eq(event.owner)
        expect(json['data']['category_id']).to eq(event.category.name)
      end
      it 'HTTP200が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)
      end
    end

    context '存在しないイベントを検索する時' do
      subject { get "/events/#{event_not_exist}" }
      it 'エラーメッセージが返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('存在しないイベントです') 
      end
      it  'HTTP404が返される' do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end
  end
end
