module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  def require_authentication
    return if current_user

    redirect_to signin_path, alert: "Please sign in to continue."
  end
end
