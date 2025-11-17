class PagesController < ApplicationController

  def index
  end

  def now
  end

  def links
    @collections = Collection.links.order(:name).includes(:links)
  end

  def thoughts
  end

  def book
  end

  def tools
    @collections = Collection.tools.order(:name).includes(:tools)
  end

  def music
    @albums = Album.order(:title)
  end

  def wishlist
    @collections = Collection.wishlist.order(:name).includes(:wishlist_items)
  end

end
