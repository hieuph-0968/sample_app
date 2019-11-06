class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, only: [:edit, :update, :destroy, :show]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    log_in @user
    if @user.save
      flash[:success] = t ".create_succes"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".updated"
      redirect_back_or @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
      redirect_to users_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.logged"
    redirect_to login_url
  end

  def correct_user
    find_user
    unless current_user? @user
      flash[:danger] = t "users.not_allow"
      redirect_to root_path
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = t "users.not_admin"
      redirect_to root_path
    end
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".id_un_exist"
    redirect_to root_path
  end
end
