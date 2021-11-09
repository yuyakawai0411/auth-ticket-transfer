class UsersController < ApplicationController

  def index
    @users = User.all
    if @users.blank? 
      render json: { status: 404, message: 'ユーザー登録はありません' }
    else
      transfer_to_json(@users)
      render json: { status: 200, data: @data }
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.blank? 
      render json: { status: 404, message: '存在しないユーザーです' }
    else
      transfer_to_json(@user)
      render json: { status: 200, data: @data }
    end
  end

  private
  
  def transfer_to_json(user_data)
    @data = []
    if user_data.is_a?(ActiveRecord::Relation)
      user_data.each do |user|
        @data << {
          id: user.id,
          nickname: user.nickname,
          email: user.email,
          phone_number: user.phone_number
        }
      end
    else
      @data << {
        id: user_data.id,
        nickname: user_data.nickname,
        email: user_data.email,
        phone_number: user_data.phone_number
      }
    end
  end

end
