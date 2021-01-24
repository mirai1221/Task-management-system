class SessionsController < ApplicationController
  skip_before_action :login_required # フィルタを通らない様にする

  def new; end

  def create
    # 送られてきたメールアドレスでユーザーの検索
    user = User.find_by(email: session_params[:email])
    # authenticateはUserクラスにhas_secure_passwordと記述していると自動で追加されるメソッド
    # 引数で受け取った値をハッシュ化して、その結果がUserオブジェクトのdigestと一致するか調べる
    if user&.authenticate(session_params[:password])
      #seiion[:user_id]にログイン中のuserのidを入れる
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def session_params
    # ストロングパラメータ
    params.require(:session).permit(:email, :password)
  end
end
