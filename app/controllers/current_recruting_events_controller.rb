class CurrentRecrutingEventsController < ApplicationController
  before_action :require_user_logged_in, only: [:index]    
  before_action :set_current_recruting_event, only: [:show, :destroy]

  def index
    if logged_in?
      @current_recruting_event = current_user.current_recruting_events.build  # form_with 用
      @current_recruting_events = current_user.feed_current_recruting_events.order(id: :desc).page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @current_recruting_event = CurrentRecrutingEvent.new
  end
  
  def create
    @current_recruting_event = current_user.current_recruting_events.build(current_recruting_event_params)

    if @current_recruting_event.save
      flash[:success] = '現在募集中の大会・行事が正常に投稿されました'
      redirect_to @current_recruting_event
    else
      @current_recruting_events = current_user.feed_current_recruting_events.order(id: :desc).page(params[:page])
      flash.now[:danger] = '現在募集中の大会・行事が投稿されませんでした'
      render :new
    end
  end
  
  def destroy
    @current_recruting_event.destroy

    flash[:success] = '現在募集中の大会・行事は正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_current_recruting_event
    @current_recruting_event = CurrentRecrutingEvent.find(params[:id])
  end

  def current_recruting_event_params
    params.require(:current_recruting_event).permit(:end_of_application, :date_of_event, :event_name ,:application_form)
  end

  def correct_user
    @current_recruting_event = current_user.current_recruting_events.find_by(id: params[:id])
    unless @current_recruting_event
      redirect_to root_url
    end
  end
end