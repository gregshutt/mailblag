class HomeController < ApplicationController
  def index
    # load up all the posts
    @posts = Post.order(post_date: :desc).limit(2)
  end
end