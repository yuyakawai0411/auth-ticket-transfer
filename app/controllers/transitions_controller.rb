class TransitionsController < ApplicationController
  before_action :user_exist?, only: [:index, :show, :create]
  before_action :ticket_exist?, only: [:index, :show, :create]

  def index
    @transitions = @ticket.transitions.includes([:sender, :recever]).order(created_at: 'DESC')
    if @transitions.blank?
      render json: { status: 404, message: '譲渡履歴は存在しません' }
    else
      @data = []
      @transitions.each do |transition|
        @data << transition.transfer_to_json
      end
      render json: { status: 200, data: @data }
    end
  end

  def show
    @transition = @ticket.transitions.includes([:sender, :recever]).find_by(id: params[:id])
    if @transition.blank?
      render json: { status: 404, message: '存在しない譲渡履歴です' }
    else
      @data = @transition.transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def create
    @transfer = Transition.new(transfer_ticket_params) 
    if @transfer.invalid?
      render json: { status: 404, message: '送り手を選択してください' } 
    else
      @transfer.transfer(@ticket)
      @data = @transfer.transfer_to_json
      render json: { status: 200, data: @data } 
    end
  end

  private

  def user_exist?
    @user = User.find_by(id: params[:user_id])
    if @user.blank?
      render json: { status: 404, message: '存在しないユーザーです' } 
    end
  end

  def ticket_exist?
    @ticket = @user.tickets.find_by(id: params[:ticket_id])
    if @ticket.blank?
      render json: { status: 404, message: '存在しないチケットです' } 
    end
  end


  def transfer_ticket_params
    params.permit(:recever_id, :ticket_id).merge(sender_id: params[:user_id])
  end

end
