class CommentsController < ApplicationController
  before_action :validate_comment_type, only: [:index, :create]

  def index
    @horse_race = HorseRace.find(params[:horse_race_id])
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
    params.require(:comment).permit(:parent_id, :description, :user_name)
          .merge({ comment_type: params[:comment_type] })
          .merge({ description: helpers.strip_tags(params[:comment][:description]),
                   user_name: helpers.strip_tags(params[:comment][:user_name]) })
  end

  def validate_comment_type
    return if (Comment.comment_types.keys).include?(params[:comment_type])

    render template: 'errors/error_400', status: 400
  end
end
