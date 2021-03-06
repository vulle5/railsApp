class ArticlesController < ApplicationController
  # before these action run method set_article
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :same_user, only: %i[edit update destroy]

  # This method is called when route articles#new is found
  # If method is empty it will look for views/articles folder and
  # look for file new.html.erb and send it to user
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    # article.save returns false if saving failed
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
    # Get id from params
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully deleted'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def same_user
    return if current_user == @article.user || current_user.admin?

    flash[:danger] = 'You can only edit and delete your own articles'
    redirect_to root_path
  end
end
