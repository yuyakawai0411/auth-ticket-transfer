class TransitionsController < ApplicationController
  before_action :user_exist?, only: [:index, :show, :create]
  before_action :ticket_exist?, only: [:index, :show, :create]
  before_action :recever_exist?, only: [:create]

  def index
    @transitions = @ticket.transitions.includes([:sender, :recever]).order(created_at: 'DESC')
    if @transitions.blank?
      render json: { status: 404, message: '譲渡履歴は存在しません' }
    else
      transfer_to_json(@transitions)
      render json: { status: 200, data: @data }
    end
  end

  def show
    @transition = @ticket.transitions.includes([:sender, :recever]).find_by(id: params[:id])
    if @transition.blank?
      render json: { status: 404, message: '存在しない譲渡履歴です' }
    else
      transfer_to_json(@transition)
      render json: { status: 200, data: @data }
    end
  end

  def create
    @transfer = Transition.new(transfer_ticket_params) 
    if @transfer.invalid?
      render json: { status: 404, message: '送り手を選択してください' } 
    else
      Transition.transfer(@transfer, @ticket)
      transfer_to_json(@transfer)
      render json: { status: 200, data: @data } 
    end
  end

  private

  def user_exist?
    @user = User.find_by(id: params[:user_id])
    if @user.blank?
      render json: { status: 404, message: '存在しないユーザーです' } 
    end
  end

  def ticket_exist?
    @ticket = @user.tickets.find_by(id: params[:ticket_id])
    if @ticket.blank?
      render json: { status: 404, message: '存在しないチケットです' } 
    end
  end

  def recever_exist?
    @recever = User.find_by(id: params[:recever_id])
    if @recever.blank?
      render json: { status: 404, message: '送り手は存在しないユーザーです' } 
    end
  end

  def transfer_ticket_params
    params.permit(:recever_id, :ticket_id).merge(sender_id: params[:user_id])
  end

  def transfer_to_json(transition_data)
    @data = []
    if transition_data.is_a?(ActiveRecord::Relation)
      @transitions.each do |transition|
        @data << {
          id: transition.id,
          ticket_id: transition.ticket.ticket_name,
          sender_id: transition.sender.nickname,
          recever_id: transition.recever.nickname,
          created_at: Time.parse(transition.created_at.to_s).to_i
        }
      end
    else
      @data << {
        id: transition_data.id,
        ticket_id: transition_data.ticket.ticket_name,
        sender_id: transition_data.sender.nickname,
        recever_id: transition_data.recever.nickname,
        created_at: Time.parse(transition_data.created_at.to_s).to_i
      }
    end
  end

end
