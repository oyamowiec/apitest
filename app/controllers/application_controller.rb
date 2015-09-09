class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def restrict_access
    api_key = APIKey.find_by_access_token(params[:access_token])
    head :unauthorized unless api_key
  end
end
