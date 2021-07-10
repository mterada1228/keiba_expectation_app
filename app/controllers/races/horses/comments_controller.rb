module Races
  module Horses
    class CommentsController < ApplicationController
      def index
        # TODO: 処理を実装
        @position = params[:position]
      end
    end
  end
end
