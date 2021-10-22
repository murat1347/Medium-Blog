class WelcomeController < ApplicationController

  def index
    redirect_to feed_users_path if current_user
  end

  private
  def article_params
    params.require(:book).permit(:title, :user, :content, :released_at,:visible)
  end
end
