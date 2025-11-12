class PagesController < ApplicationController

  def index
  end

  def now
  end

  def links
  end

  def thoughts
  end

  def book
  end

  def tools
  end

  def music
    @albums = Album.order(:title)
  end

  def wishlist
  end

  def styleguide
  end

end
