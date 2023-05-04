class TasksController < ApplicationController

  before_action :find_task, only: [:update, :destroy, :show]

  def index
    @tasks = Task.all
    render json: @tasks
  end

  def show
    puts @task.status
    if @task.status == true
      @task.update(status: false )
    else
      @task.update(status: true )
    end
    render json: @task
  end

  def create
    @task = Task.create(get_params)
    render json: @task
  end

  def update
    @task.update(get_params)
    render json: @task
  end

  def destroy
    @task.destroy()
    render json: @task
  end


  private

  def find_task
    @task = Task.find(params[:id])
  end

  def get_params
    params.require(:task).permit(:id, :title, :status)
  end
end
