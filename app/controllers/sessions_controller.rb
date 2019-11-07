class SessionsController < ApplicationController
  before_action :load_user, only: :create
  def new; end

  def create
    if @user.authenticate params[:session][:password]
      if @user.activated?
        log_in @user
        check_remember params[:session][:remember_me]
        redirect_back_or @user
      else
        flash[:warning] = t "sessions.create.activate"
        redirect_to root_path
      end
    else
      flash.now[:danger] = t "sessions.create.faild"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def check_remember remember
    remember == Settings.value_remember ? remember(@user) : forget(@user)
  end

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user
    flash[:danger] = t ".load_user"
    redirect_to login_path
  end
end
