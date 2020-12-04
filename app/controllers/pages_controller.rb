class PagesController < ApplicationController

  def index
    @description = "Yo 👋! Welcome to the home of Tim Whitacre, an engineer turned entrepreneur based in Atlanta. Let's make things."
    @latest_articles = Article.order("published_at ASC").last(3).reverse
    @featured_projects = Project.order('started ASC').where(featured: true)
  end

  def about
    @title = "About"
    @description = "Everything you ever wanted to know."
  end

  def wishlist
    @title = "Wishlist"
    @description = "Mostly for friends & family, here are things I'd like to own one day."
    @wishlist = WishlistItem.all
  end

end