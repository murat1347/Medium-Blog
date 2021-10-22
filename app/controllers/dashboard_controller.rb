class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles.all

    @comments = []

    @articles.each { |article|
      article.comments.each { |comment|
        if comment.user_id != current_user.__id__
          @comments << comment
        end
      }
    }

  end
end
