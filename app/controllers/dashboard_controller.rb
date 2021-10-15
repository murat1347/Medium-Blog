class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles.all

    @comments = []

    @articles.each { |article|
      article.comments.each { |comment|
        if comment.user_id != current_user.__id__ && !comment.accepted
          @comments << comment
        end
      }
    }

    #@comments = Comment.accepteds_by_user(current_user.id)
  end
end
