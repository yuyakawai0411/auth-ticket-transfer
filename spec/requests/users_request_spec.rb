require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
    context 'ユーザー情報が存在する時' do
      it 'ユーザー情報が表示され、HTTP200が返される' do

      end
    end

    context 'ユーザー情報が存在しない時' do
      it 'ユーザー情報が表示されず、HTTP200が返される' do

      end
    end
  end

  describe 'GET #show' do
    context '存在するユーザーを検索した時' do
      it 'ユーザー情報が表示され、HTTP200が返される' do

      end
    end

    context '存在しないユーザーを検索した時' do
      it 'エラーメッセージが表示され、HTTP404が返される' do

      end
    end

    context 'ユーザーを指定せずにリクエストした時' do
      it 'エラーメッセージが表示され、HTTP404が返される' do

      end
    end
  end

end
