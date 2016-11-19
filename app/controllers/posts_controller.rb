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

  def search
    site = current_tenant

    @search = Post.search do
      with :site_id, site.id
      fulltext params[:q]

      order_by :score
      order_by :post_date, :desc

      paginate page: 1, per_page: 25
    end
  end
end