class ArticlesController < ApplicationController

  def index 
    @title = 'Articles'
    @description = "Sometimes I write. Sometimes I wait years before I write again."
    @articles = Article.order("published_at ASC").reverse
  end

  def show
    @article = Article.find_by(slug: params[:id])
    @title = @article.title
  end
  
end