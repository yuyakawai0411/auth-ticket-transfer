class TicketsController < ApplicationController
  before_action :user_exist?, only: [:index, :show]

  def index
    unless @tickets = @user.tickets.order(ticket_name: 'DESC')
      render json: { status: 404, message: 'チケットは持っていません' }
    else
      transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def show
    unless @ticket = @user.tickets.find_by(id: params[:id])
      render json: { status: 404, message: '存在しないチケットです' }
    else
      single_transfer_to_json
      render json: { status: 200, data: @data }
    end
  end


  private

  def user_exist?
    unless @user = User.find_by(id: params[:user_id])
      render json: { status: 404, message: '存在しないユーザーです' }
    end
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
