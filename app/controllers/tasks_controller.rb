class TasksController < ApplicationController
  before_action :set_task, only:[:show,:edit,:update,:destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      TaskMailer.creation_email(@task).deliver_now # メイラーの即時送信を行うメソッド
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      flash[:notice] = "タスクを登録出来ませんでした。"
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。" # GCが動いている可能性がある
  end

  private
  def task_params
    params.require(:task).permit(:name,:description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])#ログインユーザーのIDも一緒に保存する必要あり
  end
end
