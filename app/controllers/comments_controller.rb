class CommentsController < ApplicationController
  def index
    @position = params[:position]
    @comment = Comment.new
  end

  def create
    horse_race = HorseRace.find(params[:horse_race_id]) 
    @comment = horse_race.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to horse_race_comments_path(horse_race, params[:position])
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      render 'index'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :user_name, :position)
  end
end
