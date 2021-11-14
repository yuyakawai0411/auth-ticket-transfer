class TransitionsController < ApplicationController
  before_action :ticket_exist?, only: [:index, :show, :create]

  def index
    return render json: { status: 404, message: '所持していないチケットです' } if @ticket.blank?
    @transitions = @ticket.transitions.includes([:sender, :receiver]).order(created_at: 'DESC')
    if @transitions.blank?
      render json: { status: 404, message: '譲渡履歴は存在しません' }
    else
      @data = @transitions.map{|x| x.transfer_to_json} 
      render json: { status: 200, data: @data }
    end
  end

  def show
    return render json: { status: 404, message: '所持していないチケットです' } if @ticket.blank?
    @transition = @ticket.transitions.includes([:sender, :receiver]).find_by(id: params[:id])
    if @transition.blank?
      render json: { status: 404, message: '存在しない譲渡履歴です' }
    else
      @data = @transition.transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def create
    return render json: { status: 404, message: '所持していないチケットです' } if @ticket.blank?
    @transfer = Transition.new(transfer_ticket_params) 
    if @transfer.invalid?
      render json: { status: 422, message: @transfer.errors.full_messages } 
    else
      @transfer.transfer(@ticket)
      @data = @transfer.transfer_to_json
      render json: { status: 201, data: @data } 
    end
  end

  private
  
  def transfer_ticket_params
    params.permit(:receiver_id, :ticket_id).merge(sender_id: params[:user_id])
  end

  def ticket_exist?
    @user = User.find_by(id: params[:user_id])
    if @user.blank?
      @ticket = []
    else
      @ticket = @user.tickets.find_by(id: params[:ticket_id])
    end
  end

end
