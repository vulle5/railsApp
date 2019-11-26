class ArticlesController < ApplicationController
  # This method is called when route articles#new is found
  # If method is empty it will look for views/articles folder and
  # look for file new.html.erb and send it to user
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # article.save returns false if saving failed
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    # Get id from params
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end