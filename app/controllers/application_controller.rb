class ApplicationController < ActionController::Base
  helper_method :current_user #コントローラーにあるメソッドをへるぱーのようにビューで使える
  before_action :login_required
  before_action :basic_auth, if: :production?

  private

  def current_user
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
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
