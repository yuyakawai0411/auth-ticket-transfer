class TicketsController < ApplicationController
  before_action :user_exist?, only: [:index, :show]

  def index
    @tickets = @user.tickets
    if @tickets.blank?
      render json: { status: 404, message: 'チケットは持っていません' }
    else
      transfer_to_json(@tickets)
      render json: { status: 200, data: @data }
    end
  end

  def show
    @ticket = @user.tickets.find_by(id: params[:id])
    if @ticket.blank?
      render json: { status: 404, message: '存在しないチケットです' }
    else
      transfer_to_json(@ticket)
      render json: { status: 200, data: @data }
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.invalid?
      render json: { status: 404, message: 'チケット情報を全て入力してください' } 
    else
      transfer_to_json(@ticket)
      render json: { status: 200, data: @data }
    end
  end

  private

  def ticket_params
    params.permit(:ticket_name, :event_date, :category_id, :status_id, :user_id)
  end

  def user_exist?
    @user = User.find_by(id: params[:user_id])
    if @user.blank? 
      render json: { status: 404, message: '存在しないユーザーです' } 
    end
  end

  def transfer_to_json(ticket_data)
    @data = []
    if ticket_data.is_a?(ActiveRecord::Relation)
      ticket_data.each do |ticket|
        @data << {
          id: ticket.id,
          ticket_name: ticket.ticket_name,
          event_date: ticket.event_date,
          category_id: ticket.category.name,
          status_id: ticket.status.name,
          user_id: ticket.user.nickname,
          created_at: Time.parse(ticket.created_at.to_s).to_i
        }
      end
    else
      @data << {
        id: ticket_data.id,
        ticket_name: ticket_data.ticket_name,
        event_date: ticket_data.event_date,
        category_id: ticket_data.category.name,
        status_id: ticket_data.status.name,
        user_id: ticket_data.user.nickname,
        created_at: Time.parse(ticket_data.created_at.to_s).to_i
      }
    end
  end

end
