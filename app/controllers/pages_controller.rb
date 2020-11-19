class PagesController < ApplicationController

  def index
    @description = "Yo 👋! Welcome to the home of Tim Whitacre, an engineer turned entrepreneur based in Atlanta. Let's make things."
    @latest_articles = Article.order("published_at ASC").last(3).reverse
    @active_projects = Project.order('started ASC').where(active: true)
  end

  def about
    @title = "About"
    @description = "Everything you ever wanted to know."
  end

end