class TicketsController < ApplicationController
  before_action :user_exist?, only: [:index, :show]
  before_action :event_exist?, only: [:create]

  def index
    return render json: { status: 404, message: '登録されていないユーザーです' } if @user.blank? 
    @tickets = @user.tickets.includes(:event)
    if @tickets.blank?
      render json: { status: 404, message: 'チケットは所持していません' }
    else
      @data = @tickets.map{|x| x.transfer_to_json} 
      render json: { status: 200, data: @data }
    end
  end

  def show
    return render json: { status: 404, message: '登録されていないユーザーです' } if @user.blank? 
    @ticket = @user.tickets.find_by(id: params[:id])
    if @ticket.blank?
      render json: { status: 404, message: '所持していないチケットです' }
    else
      @data = @ticket.transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def create
    return render json: { status: 404, message: '登録されていないイベントです' } if @event.blank? 
    @ticket = Ticket.new(ticket_params)
    if @ticket.invalid?
      render json: { status: 422, message: @ticket.errors.full_messages } 
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

  def event_exist?
    @event = Event.find_by(id: params[:event_id])
  end

end
