class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)#安全なデータを使ってオブジェクトを作成しデータベースに保存する
    if task.save!
      redirect_to tasks_url, notice: "タスク「#{task.name}」を登録しました。"
    else
      flash[:notice] = "タスクを登録出来ませんでした。"
      render action: :new
    end
  end

  def edit
  end

  private
  def task_params
    params.require(:task).permit(:name,:description)
  end
end
