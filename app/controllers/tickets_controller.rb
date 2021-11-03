class TicketsController < ApplicationController
  before_action :set_user_info, only: [:index, :show]

  def index
    @tickets = @user.tickets
  end

  def show
    @ticket = @user.tickets.find_by(id: params[:id])
  end


  private

  def set_user_info
    @user = User.find(params[:id]).includes(:tickets)
  end

end
