class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_api_user!
    user = user_signed_in?
    return _not_authorized unless user
  end

  def user_signed_in?
    token = UserAuthenticationToken.find_by_token params[:auth_token]
    user  = token.user if token
    return user
  end

  def _not_authorized message = t(:not_authorized)
    render json: {errors: { errors: message} }, status: 401
  end
end