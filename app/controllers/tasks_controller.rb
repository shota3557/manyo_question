class TasksController < ApplicationController
  def new
      @task = Task.new
    end
  
  def index
    @tasks = Task.all
  end
  
  def create
    @task = Task.create(task_params)
    if @task.save
      flash[:notice] = "投稿しました"
      redirect_to tasks_path, notice: "投稿しました"
    else
      render :new  
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
    redirect_to tasks_path, notice: "投稿を削除しました"
  end

  def confirm
    @task = Task.new(task_params)
  end
  
  private
  def task_params
    params.require(:task).permit(:name, :content)
  end
end  
