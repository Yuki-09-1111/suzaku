class PracticeResultsController < ApplicationController
  before_action :require_user_logged_in, only: [:index]    
  before_action :set_practice_result, only: [:show, :destroy]

  def index
    if logged_in?
      @practice_result = current_user.practice_results.build  # form_with 用
      @practice_results = current_user.feed_practice_results.order(id: :desc).page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @practice_result = PracticeResult.new
  end
  
  def create
    @practice_result = current_user.practice_results.build(practice_result_params)

    if @practice_result.save
      flash[:success] = '練習ノートが正常に投稿されました'
      redirect_to @practice_result
    else
      @practice_results = current_user.feed_practice_results.order(id: :desc).page(params[:page])
      flash.now[:danger] = '練習ノートが投稿されませんでした'
      render :new
    end
  end
  
  def destroy
    @practice_result.destroy

    flash[:success] = '練習ノートは正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_practice_result
    @practice_result = PracticeResult.find(params[:id])
  end

  def practice_result_params
    params.require(:practice_result).permit(:chart_of_practice)
  end

  def correct_user
    @practice_result = current_user.practice_results.find_by(id: params[:id])
    unless @practice_result
      redirect_to root_url
    end
  end
end
