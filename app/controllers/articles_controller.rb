class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy vote_plus vote_minus]
  before_action :authenticate_user!

  def index
    @articles = Article.visible
  end

  def show
    @comments = @article.comments.accepteds_and_user_created(current_user.id)
  end

  def new
    @article = current_user.articles.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def vote_plus
    @article.update(vote: @article.vote + 1)
    respond_to do |format|
      format.js
    end
  end

  def vote_minus
    @article.update(vote: @article.vote - 1)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :visible)
  end
end
