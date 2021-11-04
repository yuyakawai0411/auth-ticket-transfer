class TransitionsController < ApplicationController
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

  def single_transfer_to_json
    @data = []
      @data << {
        ticket: @transfer_ticket.ticket,
        sender: @transfer_ticket.sender,
        recever: @transfer_ticket.recever
      }
    @data.to_json
  end
end
