class ApplicationController < ActionController::Base
    # everything in this application controller becomes inherited by the 
    # subclass controllers (movies reviews sessions and users)

private

def require_login
    unless current_user
        session[:intended_url] = request.url
        redirect_to new_session_url, alert: "Please log in first!"
    end
end

# RUBY IDIOM ||=
def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

helper_method :current_user

def current_user?(user)
    current_user == user
end

helper_method :current_user?

end
  # ^^^^ Reminder to put private methods in the class not outside of it!
