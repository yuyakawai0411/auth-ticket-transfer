class TicketsController < ApplicationController
  before_action :user_exist?, only: [:index, :show]

  def index
    return render json: { status: 404, message: '存在しないユーザーです' } if @user.blank? 
    @tickets = @user.tickets.includes(:event)
    if @tickets.blank?
      render json: { status: 404, message: 'チケットは持っていません' }
    else
      @data = @tickets.map{|x| x.transfer_to_json} 
      render json: { status: 200, data: @data }
    end
  end

  def show
    return render json: { status: 404, message: '存在しないユーザーです' } if @user.blank? 
    @ticket = @user.tickets.find_by(id: params[:id])
    if @ticket.blank?
      render json: { status: 404, message: '存在しないチケットです' }
    else
      @data = @ticket.transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.invalid?
      render json: { status: 404, message: @ticket.errors.full_messages } 
    else
      @ticket.save
      @data = @ticket.transfer_to_json
      render json: { status: 201, data: @data }
    end
  end

  private

  def ticket_params
    params.permit(:user_id, :event_id, :availabilty_date).merge(status_id: 1)
  end

  def user_exist?
    @user = User.find_by(id: params[:user_id])
  end

end
