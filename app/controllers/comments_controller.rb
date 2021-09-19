class CommentsController < ApplicationController
  before_action :validate_url, only: [:show]
  before_action :validate_query, only: [:index]
  before_action :validate_comment_params, only: [:create]

  def index
    @horse_race = HorseRace.find(params[:horse_race_id])
    @existing_comments = @horse_race.comments.where(comment_type: params[:comment_type])
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

  def validate_url
    param! :id, Integer, require: true
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
