class Admin::UsersController < ApplicationController
  before_action :admin_user
  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def index
    @users = User.all.order(id: :asc)
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.all.includes(:user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(admin_user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin == false
      @user.destroy
      flash[:danger] = "ユーザを削除しました"
      redirect_to admin_users_path
    else
      flash[:danger] = "管理者は削除できません"
      redirect_to admin_users_path
    end  
  end

  private
  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "管理者以外アクセスできません"
      redirect_to tasks_path 
    end
  end  
end
