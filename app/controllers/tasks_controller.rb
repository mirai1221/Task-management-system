class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  # Ransack simplemode
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page])

    respond_to do |format|
      format.html
      # format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: 'タスクを追加しました'
  end

  def show; end

  def new
    @task = Task.new
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def create
    # 関連を利用してログインしているuser_idをTaskデータに登録できている
    # 直前にユーザーが入力した値をフォームに引き継いで入力する
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
      # TaskMailer.creation_email(@task).deliver_now # メイラーの即時送信を行うメソッド
      # SampleJob.perform_later
    else
      flash[:notice] = 'タスクを登録出来ませんでした。'
      render :new
    end
  end

  def edit; end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private
  # フォームからリクエストパラメータとして送られてきたデータが想定どおりかをチェックしpermit後のデータだけを受け取る
  def task_params
    params.require(:task).permit(:name, :description, :image, :status)
  end

  def set_task
    @task = current_user.tasks.find(params[:id]) # ログインユーザーのIDも一緒に保存する必要あり
  end
end
