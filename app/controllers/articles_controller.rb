class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        
    end

    def create
        @article = Article.new(article_params)
        # render plain: @article.inspect
        # byebug
        if @article.save
            flash[:notice] = "Article was created successfully."
            redirect_to @article
        else
            render 'new'
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render "edit"
        end
    end

    private

    def article_params
        params.require(:article).permit(:title, :description)
    end

end