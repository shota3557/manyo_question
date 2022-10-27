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
  
  end
  
  def destroy
  
  end
  
  private
  def task_params
    params.require(:task).permit(:name, :content)
  end
end  
