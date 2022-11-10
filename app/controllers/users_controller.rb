class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    if current_user
      redirect_to new_task_path 
    else
      @user = User.new
    end  
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.all.includes(:user)
    redirect_to tasks_path unless current_user.id == @user.id
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end  