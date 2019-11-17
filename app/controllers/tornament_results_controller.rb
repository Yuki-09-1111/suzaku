class TournamentResultsController < ApplicationController
  before_action :require_user_logged_in, only: [:index]    
  before_action :set_tournament_result, only: [:show, :destroy]

  def index
    if logged_in?
      @tournament_result = current_user.tournament_results.build  # form_with 用
      @tournament_results = current_user.feed_tournament_results.order(id: :desc).page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @tournament_result = TournamentResult.new
  end
  
  def create
    @tournament_result = current_user.tournament_results.build(tournament_result_params)

    if @tournament_result.save
      flash[:success] = '大会結果が正常に投稿されました'
      redirect_to @tournament_result
    else
      @tournament_results = current_user.feed_tournament_results.order(id: :desc).page(params[:page])
      flash.now[:danger] = '大会結果が投稿されませんでした'
      render :new
    end
  end
  
  def destroy
    @tournament_result.destroy

    flash[:success] = '大会結果は正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_tournament_result
    @tournament_result = TournamentResult.find(params[:id])
  end

  def tournament_result_params
    params.require(:tournament_result).permit(:date_of_tournament, :name ,:content)
  end

  def correct_user
    @tournament_result = current_user.tournament_results.find_by(id: params[:id])
    unless @tournament_result
      redirect_to root_url
    end
  end
end
