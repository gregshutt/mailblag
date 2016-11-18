class PostsController < ApplicationController
  def index

    if params[:date].present?
      @posts = Post.where('DATE(post_date) = ?', params[:date])
    else
      @posts = Post.limit(15)
    end

    # load up all the posts
    @posts = @posts.order(post_date: :desc)
    @all_posts = Post.order(post_date: :desc).all
  end
end