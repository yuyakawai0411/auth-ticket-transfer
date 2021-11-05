class TransitionsController < ApplicationController
  def index
    @transitions = Transition.all
    if @transitions.nil?
      render json: { status: 404, message: '譲渡履歴は存在しません' }
    else
      transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def show
    @transition = Transition.find(params[:id])
    if @transition.nil?
      render json: { status: 404, message: '存在しないユーザーです' }
    else
      single_transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def create
    @transfer_ticket = Transition.new(transfer_ticket_params)
    if @transfer_ticket.valid?
      @transfer_ticket.save
      Ticket.deposit(@transfer_ticket.ticket, @transfer_ticket.recever)
      Ticket.wisdraw(@transfer_ticket.ticket)
      single_transfer_to_json
      render json: { status: 200, data: @data }
    else
      render json: { status: 404, message: 'チケットは持っていません' }
    end
  end

  private
  def transfer_ticket_params
    params.permit(:ticket, :sender, :recever)
  end

  def transfer_to_json
    @data = []
    @transitions.each do |transition|
      @data << {
        id: transition.id,
        ticket: transition.ticket,
        sender: transition.sender,
        recever: transition.recever,
        created_at: Time.parse(transition.created_at.to_s).to_i
      }
    end
    @data.to_json
  end

  def single_transfer_to_json
    @data = []
      @data << {
        id: @transition.id,
        ticket: @transition.ticket,
        sender: @transition.sender,
        recever: @transition.recever,
        created_at: Time.parse(@transition.created_at.to_s).to_i
      }
    @data.to_json
  end


end
