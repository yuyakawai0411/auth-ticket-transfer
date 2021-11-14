class UsersController < ApplicationController

  def index
    @users = User.all
    if @users.blank? 
      render json: { status: 404, message: '登録されているユーザーはありません' }
    else
      @data = @users.map{|x| x.transfer_to_json} 
      render json: { status: 200, data: @data }
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.blank? 
      render json: { status: 404, message: '登録されていないユーザーです' }
    else
      @data = @user.transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

end
