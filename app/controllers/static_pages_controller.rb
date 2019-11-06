class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.microposts.order_desc.paginate page:
      params[:page], per_page: Settings.size_10
  end

  def help; end

  def about; end

  def contact; end
end
