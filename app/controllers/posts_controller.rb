class PostsController < ApplicationController
  def index

    if params[:start_date].present?
      @start_date = Date.parse(params[:start_date])
      @posts = Post.where(post_date: @start_date.beginning_of_day .. @start_date.end_of_day)
    else
      @start_date = Date.today
      @posts = Post.limit(8)
    end

    # load up all the posts
    @posts = @posts.order(post_date: :desc)
    @all_posts = Post.order(post_date: :desc).all
  end

  def calendar
    @start_date = Date.strptime(params[:start_date], '%m/%d/%Y').beginning_of_month
    @all_posts = Post.order(post_date: :desc).all
  end
end