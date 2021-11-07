class TransitionsController < ApplicationController
  before_action :user_exist?, only: [:index, :show, :create]
  before_action :ticket_exist?, only: [:index, :show, :create]

  def index
    unless @transitions = @ticket.transitions.order(created_at: 'DESC')
      render json: { status: 404, message: '譲渡履歴は存在しません' }
    else
      transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def show
    unless @transition = @ticket.transitions.find_by(id: params[:id])
      render json: { status: 404, message: '存在しない譲渡履歴です' }
    else
      single_transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

  def create
    @transition = Transition.new(transfer_ticket_params)
    if @transition.valid?
      if @transition.recever_id == @transition.sender_id 
        render json: { status: 404, message: '送り手に自分を選択できません' } 
      elsif User.find_by(id: params[:recever_id])
        @transition.save
        Ticket.transfer(@transition.ticket_id, @transition.recever_id)
        single_transfer_to_json
        render json: { status: 200, data: @data } 
      else
        render json: { status: 404, message: '送り手は存在しないユーザーです' } 
      end
    else
      render json: { status: 404, message: 'チケット譲渡に失敗しました' } 
    end
  end

  private

  def user_exist?
    unless @user = User.find_by(id: params[:user_id])
      render json: { status: 404, message: '存在しないユーザーです' } 
    end
  end

  def ticket_exist?
    unless @ticket = @user.tickets.find_by(id: params[:ticket_id])
      render json: { status: 404, message: '存在しないチケットです' } 
    end
  end

  # def recever_exist?
  #   if @transition.recever_id == @transition.sender_id 
  #     render json: { status: 404, message: '送り手に自分を選択できません' } 
  #   elsif User.find_by(id: params[:recever_id])
  #     render json: { status: 404, message: '送り手は存在しないユーザーです' } 
  #   end
  # end

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
