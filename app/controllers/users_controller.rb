class UsersController < ApplicationController

  def index
    unless @users = User.all.order(nickname: 'DESC')
      render json: { status: 404, message: 'ユーザー登録はありません' }
    else
      transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def show
    unless @user = User.find_by(id: params[:id])
      render json: { status: 404, message: '存在しないユーザーです' }
    else
      single_transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  private

  def transfer_to_json
    @data = []
    @users.each do |user|
      @data << {
        id: user.id,
        nickname: user.nickname,
        email: user.email,
        phone_number: user.phone_number
      }
    end
    @data.to_json
  end

  def single_transfer_to_json
    @data = []
      @data << {
        id: @user.id,
        nickname: @user.nickname,
        email: @user.email,
        phone_number: @user.phone_number
      }
    @data.to_json
  end

end
