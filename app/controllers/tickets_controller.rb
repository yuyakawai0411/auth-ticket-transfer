class TicketsController < ApplicationController
  before_action :set_user_info, only: [:index, :show]

  def index
    @tickets = @user.tickets
    if @tickets.nil?
      render json: { status: 404, message: 'チケットは持っていません' }
    else
      transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def show
    @ticket = @user.tickets.find_by(id: params[:id])
    if @ticket.nil?
      render json: { status: 404, message: 'チケットは持っていません' }
    else
      single_transfer_to_json
      render json: { status: 200, data: @data }
    end
  end


  private

  def set_user_info
    @user = User.find(params[:user_id])
  end

  def transfer_to_json
    @data = []
    @tickets.each do |ticket|
      @data << {
        id: ticket.id,
        ticket_name: ticket.ticket_name,
        event_date: ticket.event_date,
        category: ticket.category.name,
        status: ticket.status.name,
        created_at: Time.parse(ticket.created_at.to_s).to_i
      }
    end
    @data.to_json
  end

  def single_transfer_to_json
    @data = []
      @data << {
        id: @ticket.id,
        ticket_name: @ticket.ticket_name,
        event_date: @ticket.event_date,
        category: @ticket.category.name,
        status: @ticket.status.name,
        created_at: Time.parse(@ticket.created_at.to_s).to_i
      }
    @data.to_json
  end

end
