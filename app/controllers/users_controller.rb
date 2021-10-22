class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.visible
    @comments = Comment.where(user_id: @user.id).where(accepted: true)
  end

  def feed
    @articles = current_user.feed.order(created_at: :desc)
  end

end
