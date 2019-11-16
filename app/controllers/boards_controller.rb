class BoardsController < ApplicationController
  before_action :require_user_logged_in, only: [:index]    
  before_action :set_board, only: [:show, :destroy]

  def index
    if logged_in?
      @board = current_user.boards.build  # form_with 用
      @boards = current_user.feed_boards.order(id: :desc).page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @board = Board.new
  end
  
  def create
    @board = current_user.boards.build(board_params)

    if @board.save
      flash[:success] = '掲示板が正常に投稿されました'
      redirect_to @board
    else
      @boards = current_user.feed_boards.order(id: :desc).page(params[:page])
      flash.now[:danger] = '掲示板が投稿されませんでした'
      render :new
    end
  end
  
  def destroy
    @board.destroy

    flash[:success] = '掲示板は正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:content, :title)
  end

  def correct_user
    @board = current_user.boards.find_by(id: params[:id])
    unless @board
      redirect_to root_url
    end
  end
end
