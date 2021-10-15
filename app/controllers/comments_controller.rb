# frozen_string_literal: true
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_article_user?
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.update!(user: current_user)

    redirect_to dashboard_path
  end

  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def accept
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:comment_id])
    if comment.accepted
      comment.update!(accepted: false)
    else
      comment.update!(accepted: true)
    end
    flash[:notice] = 'Process successfully.'
    redirect_to dashboard_path
  end

  def is_article_user?
    unless Article.find(params[:article_id]).user == current_user
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You don't permission to page" }
      end
    end
  end



  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
