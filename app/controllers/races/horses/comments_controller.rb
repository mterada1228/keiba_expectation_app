module Races
  module Horses
    class CommentsController < ApplicationController
      def index
        @position = params[:position]
        @comment = Comment.new
      end

      def create
        @comment = Comment.create(comment_params.merge(race_id: params[:race_id]))
        if @comment.save
          flash[:notice] = 'コメントを投稿しました'
        else
          flash[:danger] = 'コメントの投稿に失敗しました。'
        end
        redirect_to race_horse_comments_path(race_id: params[:race_id], horse_id: params[:horse_id])
      end

      private

      def comment_params
        params.require(:comment).permit(:horse_id, :race_id, :description, :user_name, :position)
      end
    end
  end
end