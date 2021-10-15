# frozen_string_literal: true
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.update!(user: current_user)

    redirect_to @article
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

  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
