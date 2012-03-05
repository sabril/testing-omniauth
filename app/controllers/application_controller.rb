class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    session["current_user"] ? OpenStruct.new(session["current_user"]) : nil
  end

  def logged_in?
    current_user.present?
  end
end
