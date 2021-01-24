class ApplicationController < ActionController::Base
  helper_method :current_user # コントローラーにあるメソッドをビューでも使えるように設定
  before_action :login_required #current_userでなければログイン画面に推移するメソッドを追加
  before_action :basic_auth, if: :production?

  private

  def current_user
    # 左辺が未定義または偽なら右辺を代入する a||=true => a || (a = true)
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
