class ArticlesController < ApplicationController

  before_action :move_to_index, except: :index

    def index
      @articles = Article.includes(:user).page(params[:page]).per(4).order("created_at DESC")
    end

    def new
    end

    def create
      Article.create(article_params)
      redirect_to action: :index
    end

    def edit
      @article = Article.find(params[:id])
    end

    def update
      article = Article.find(params[:id])
      article.update(article_params) if article.user_id == current_user.id
      redirect_to action: :index
    end

    def destroy
      article = Article.find(params[:id])
      article.destroy if article.user_id == current_user.id
      redirect_to action: :index
    end

    private

    def article_params
      params.require(:article).permit(:title, :text).merge(user_id: current_user.id)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end
end
