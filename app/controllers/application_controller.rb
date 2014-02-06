class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    alert_message = case
    when current_user
      "You are not authorized to access this page"
    else
      "You need to login as a registered user to access this page"
    end
    redirect_to root_path, alert: alert_message
  end

  private
  def current_user
    begin
      @current_user ||= Player.find(session[:player_id]) if session[:player_id]
    rescue ActiveRecord::RecordNotFound
      session.delete(:player_id)
      return nil
    end
  end
end
