module Races
  module Horses
    class CommentsController < ApplicationController
      def index
        # TODO: 処理を実装
        @type = params[:type]
      end
    end
  end
end
