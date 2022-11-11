class TasksController < ApplicationController
  def new
    @task = Task.new
  end
  
  def index
    if params[:task].present? && params[:task][:name].present? && params[:status].present? && params[:status][:name].present?
      @tasks = Task.task_name(params[:task][:name]).status_name(params[:status][:name]).page(params[:page]).per(2)
    elsif params[:task].present? && params[:task][:name].present?
      @tasks = Task.task_name(params[:task][:name]).page(params[:page]).per(2)
    elsif params[:status].present? && params[:status][:name].present?
      @tasks = Task.status_name(params[:status][:name]).page(params[:page]).per(2)
    elsif params[:sort_expired]  
      @tasks = Task.sort_expired.page(params[:page]).per(2)
    elsif params[:rank]
      @tasks = Task.rank.page(params[:page]).per(2)
    else  
      @tasks = Task.all.includes(:user).order(created_at: :desc).page(params[:page]).per(2)
    end
  end
  
  def create
    @task = Task.create(task_params)
    @task.user_id = current_user.id
    if params[:back]
      render :new
    else  
      if @task.save
        flash[:notice] = "投稿しました"
        redirect_to tasks_path
      else
        render :new  
      end
    end  
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "内容を更新しました"
      redirect_to tasks_path
    else
      render :edit  
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:danger] = "投稿を削除しました"
    redirect_to tasks_path
  end

  def confirm
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    render :new if @task.invalid?
  end
  
  private
  def task_params
    params.require(:task).permit(:name, :content, :end_date, :status, :priority, { label_ids: [] })
  end
end  