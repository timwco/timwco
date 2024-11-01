class PagesController < ApplicationController

  def index
    @description       = "Yo 👋! Welcome to the home of Tim Whitacre, an engineer turned entrepreneur based in Kansas City. Let's make things."
    @latest_articles   = Article.order("published_at ASC").last(3).reverse
    @featured_projects = Project.order('started ASC').where(featured: true)
  end

  def about
    @title       = "About"
    @description = "Everything you ever wanted to know."
    @projects_count = Project.all.count
    @acquired_count = Project.where(status: :acquired).count
  end

  def book
    @title       = "Book"
    @description = "CODE SCHOOL: Overcome Imposter Syndrome. Kick-start Your Tech Career."
  end

  def music
    @albums = Album.all
  end

  def wishlist
    @title       = "Wishlist"
    @description = "Mostly for friends & family, here are things I'd like to own one day."

    @wishlist_games   = WishlistItem.where(category: :games)
    @wishlist_tech    = WishlistItem.where(category: :tech)
    @wishlist_kitchen = WishlistItem.where(category: :kitchen)
    @wishlist_books   = WishlistItem.where(category: :books)
    @wishlist_sports  = WishlistItem.where(category: :sports)
    @wishlist_lego    = WishlistItem.where(category: :lego)
    @wishlist_misc    = WishlistItem.where(category: :misc)
    @wishlist_music   = WishlistItem.where(category: :music)
  end

end