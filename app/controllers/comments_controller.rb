class CommentsController < ApplicationController
  before_action :set_horse_race, only: [:create]

  def index
    @position = params[:position]
    @comment = Comment.new
  end

  def create
    @comment = @horse_race.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to horse_race_comments_path(@horse_race, params[:position])
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      render 'index'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :user_name, :position)
  end

  def set_horse_race
    @horse_race = HorseRace.find(params[:horse_race_id])
  rescue ActiveRecord::RecordNotFound => _e
    render template: 'errors/error_404', status: 404
  end
end
