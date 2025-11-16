class CategoriesController < ApplicationController
  def show
    @category = Category.find_by!(slug: params[:slug])
    @posts = @category.posts.published
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end
