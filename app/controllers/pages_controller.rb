class PagesController < ApplicationController

  def index
    @description = "Yo 👋! Welcome to the home of Tim Whitacre, an engineer turned entrepreneur based in Atlanta. Let's make things."
    @articles = Article.order("published_at ASC").last(3).reverse
  end

  def about
    @title = "About"
    @description = "Everything you ever wanted to know."
  end

end