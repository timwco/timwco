class PagesController < ApplicationController

  def index
    @description = "Yo 👋! Welcome to the home of Tim Whitacre, an engineer turned entrepreneur based in Atlanta. Let's make things."
  end

  def about
    @title = "About"
    @description = "Everything you ever wanted to know."
  end

end