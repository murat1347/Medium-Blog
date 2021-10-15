class WelcomeController < ApplicationController

  def index
    @articles= Article.visible
  end

  private
  def article_params
    params.require(:book).permit(:title, :user, :content, :released_at,:visible)
  end
end
