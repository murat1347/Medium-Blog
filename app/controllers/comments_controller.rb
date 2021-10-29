# frozen_string_literal: true
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        CommentJob.set(wait: 2.minutes).perform_later(@comment.id)
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(:status => true)
      redirect_to dashboard_path, notice: 'Comment status was successfully updated.'
    else
      render 'edit'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @article = Article.find(params[:article_id])
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

  def deny
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:comment_id])
    if comment.accepted
      comment.update!(accepted: true)
    else
      comment.update!(accepted: false)
    end
    flash[:notice] = 'Process successfully.'
    redirect_to dashboard_path
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content, :user_id)
  end
end
