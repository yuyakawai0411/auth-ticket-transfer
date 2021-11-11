class EventsController < ApplicationController

  def index
    @events = Event.all
    if @events.blank? 
      render json: { status: 404, message: 'イベント登録はありません' }
    else
      @data = []
      @events.each do |event|
        @data << event.transfer_to_json
      end
      render json: { status: 200, data: @data }
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    if @event.blank? 
      render json: { status: 404, message: '存在しないイベントです' }
    else
      @data = @event.transfer_to_json
      render json: { status: 200, data: @data }
    end
  end

end
