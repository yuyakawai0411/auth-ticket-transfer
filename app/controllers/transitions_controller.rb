class TransitionsController < ApplicationController
  before_action :set_ticket_info, only: [:index, :show]

  def index
    @transitions = @ticket.transitions.order(created_at: 'DESC')
    if @transitions.nil?
      render json: { status: 404, message: '譲渡履歴は存在しません' }
    else
      transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def show
    @transition = @ticket.transitions.find_by(id: params[:id])
    if @transition.nil?
      render json: { status: 404, message: '存在しないユーザーです' }
    else
      single_transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def create
    @transition = Transition.new(transfer_ticket_params)
    if @transition.valid?
      @transition.save
      Ticket.transfer(@transition.ticket_id, @transition.recever_id)
      # Ticket.deposit(@transfer_ticket.ticket_id, @transfer_ticket.recever_id)
      # Ticket.wisdraw(@transfer_ticket.ticket_id)
      single_transfer_to_json
      render json: { status: 200, data: @data }
    else
      render json: { status: 404, message: 'チケットは持っていません' }
    end
  end

  private

  def set_ticket_info
    @user = User.find(params[:user_id])
    @ticket = @user.tickets.find_by(id: params[:ticket_id])
  end

  def transfer_ticket_params
    params.permit(:recever_id).merge(ticket_id: params[:ticket_id], sender_id: params[:user_id])
  end

  def transfer_to_json
    @data = []
    @transitions.each do |transition|
      @data << {
        id: transition.id,
        ticket_id: transition.ticket_id,
        sender_id: transition.sender_id,
        recever_id: transition.recever_id,
        created_at: Time.parse(transition.created_at.to_s).to_i
      }
    end
    @data.to_json
  end

  def single_transfer_to_json
    @data = []
      @data << {
        id: @transition.id,
        ticket_id: @transition.ticket_id,
        sender_id: @transition.sender_id,
        recever_id: @transition.recever_id,
        created_at: Time.parse(@transition.created_at.to_s).to_i
      }
    @data.to_json
  end


end
