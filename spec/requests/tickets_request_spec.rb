require 'rails_helper'

RSpec.describe "Tickets", type: :request do

  describe 'GET #index' do
    context '存在するユーザーを検索した時' do
      it 'ユーザーが所持するチケットが全て表示され、HTTP200が返される' do

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

  describe 'GET #show' do
    context '存在するユーザーを検索した時' do
      context 'そのユーザーが所持しているチケットを検索した時' do
        it 'チケットが表示され、HTTP200が返される' do

        end
      end
      context 'そのユーザーが所持していないチケットを検索した時' do
        it 'エラーメッセージが表示され、HTTP404が返される' do

        end
      end
      context 'チケットを指定せず、リクエストした時' do
        it 'エラーメッセージが表示され、HTTP404が返される' do

        end
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
