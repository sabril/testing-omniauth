class SessionsController < ApplicationController

  def create
    if params[:message] == "invalid_credentials"
      flash[:error] = "Login failed"
    end

    auth = request.env["omniauth.auth"]

    unless Rails.env.test?
      puts "OmniAuth received:"
      puts auth.to_yaml
    end

    if auth
      session.clear
      session["current_user"] = { 
        provider: auth["provider"], 
        uid:      auth["uid"],
        name:     auth["info"]["name"] || auth["info"]["nickname"]
      }
    end

    # Currently assumes that we're in a popup window.
    # TODO add some detection so we can redirect_to root_path if not in a popup (with specs)
    render :close_popup, :layout => nil
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
