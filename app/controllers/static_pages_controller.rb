class StaticPagesController < ApplicationController

  before_action :check_logged_in, only: [:home]

  # caches_page :public
  # caches_action :home

  def home
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def public
    render :home
  end

  def help
  end

  def about
  end

  def contact
  end

  def check_logged_in
    redirect_to action: 'public' unless signed_in?
  end
end
