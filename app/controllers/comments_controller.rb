class CommentsController < ApplicationController
  before_action :validate_query, only: [:index, :create]
  before_action :validate_comment_params, only: [:create]

  def index
    @existing_comments = HorseRace.find(params[:horse_race_id])
                                  .comments.where(comment_type: params[:comment_type])
    @new_comment = Comment.new
  end

  def create
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
    params.require(:comment).permit(:description, :user_name, :comment_type)
  end

  def validate_query
    param! :comment_type, String, in: Comment.comment_types.keys, trandform: ->(v) { v.to_sym }
  end

  def validate_comment_params
    param! :comment, Hash, required: true do |c|
      c.param! :description,  String, required: true, transform: ->(v) { helpers.strip_tags(v) }
      c.param! :user_name,    String, required: true, transform: ->(v) { helpers.strip_tags(v) }
      c.param! :comment_type, String, required: true, in: Comment.comment_types.keys
    end
  end
end
