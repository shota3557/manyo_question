class TasksController < ApplicationController
  def new
    @task = Task.new
  end
  
  def index
    if params[:task].present? && params[:task][:name].present? && params[:status].present? && params[:status][:name].present?
      @tasks = Task.where('name Like(?)', "%#{params[:task][:name]}%")
      @tasks = @tasks.status_name(params[:status][:name])
    elsif params[:task].present? && params[:task][:name].present?
      @tasks = Task.where('name Like(?)', "%#{params[:task][:name]}%")
    elsif params[:status].present? && params[:status][:name].present?
    
      @tasks = Task.status_name(params[:status][:name])
    elsif params[:sort_expired]  
      @tasks = Task.sort_expired
    elsif params[:rank]
      @tasks = Task.rank
    else  
      @tasks = Task.all.order(created_at: :desc)
    end
  end
  
  def create
    @task = Task.create(task_params)
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
    render :new if @task.invalid?
  end
  
  private
  def task_params
    params.require(:task).permit(:name, :content, :end_date, :status, :priority)
  end
end  
