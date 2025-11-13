class PostsController < ApplicationController
  def index
    @posts = Post.published
  end

  def show
    @post = Post.published.find_by!(slug: params[:slug])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end
