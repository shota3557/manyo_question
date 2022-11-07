class Admin::UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :index]
  def new

  end

  def index
    @users = User.all
  end

  def update

  end

  def destroy

  end
end
