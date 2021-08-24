class CommentsController < ApplicationController
  before_action :sanitize_params, only: [:create]

  def index
    @horse_race = HorseRace.find(params[:horse_race_id])
    @comment_type = params[:comment_type]
    @existing_comments = HorseRace.find(params[:horse_race_id])
                                  .comments.where(comment_type: params[:comment_type].to_sym)
    @new_comment = Comment.new
  end

  def show
    @parent_comment = Comment.find(params[:id])
    @new_comment = Comment.new
  end

  def create
    horse_race = HorseRace.find(params[:horse_race_id])
    @new_comment = horse_race.comments.new(comment_params)
    if @new_comment.save
      flash[:success] = { comment: 'コメントを投稿しました' }
    else
      flash[:danger] = { comment: 'コメントの投稿に失敗しました。', errors: @new_comment.errors.full_messages }
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:parent_id, :description, :user_name, :comment_type)
  end

  def sanitize_params
    params[:comment][:user_name] = helpers.sanitize(params[:comment][:user_name])
    params[:comment][:description] = helpers.sanitize(params[:comment][:description])
  end
end
