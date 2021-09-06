class CommentsController < ApplicationController
  def index
    param! :comment_type, String, in: Comment.comment_types.keys

    @existing_comments = HorseRace.find(params[:horse_race_id])
                                  .comments.where(comment_type: params[:comment_type].to_sym)
    @new_comment = Comment.new
  end

  def create # rubocop:disable Metrics/AbcSize
    param! :comment_type, String, in: Comment.comment_types.keys
    param! :comment, Hash do |c|
      c.param! :description, String, required: true, transform: ->(v) { helpers.strip_tags(v) }
      c.param! :user_name,   String, required: true, transform: ->(v) { helpers.strip_tags(v) }
    end

    horse_race = HorseRace.find(params[:horse_race_id])
    @new_comment = horse_race.comments.new(comment_params)
    if @new_comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to horse_race_comments_path(horse_race, comment_type: @new_comment.comment_type)
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      render 'index'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :user_name)
          .merge({ comment_type: params[:comment_type] })
  end
end
