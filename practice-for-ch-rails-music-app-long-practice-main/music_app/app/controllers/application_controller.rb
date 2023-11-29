class ApplicationController < ActionController::Base
    #CHRLLL 
    #current_user/helper method/require_logged_in , require_logged_out/logged_in?/login(user)/logout!

    helper_method :current_user, :logged_in?

    #check to see if current cookie is already in use for a user
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end 

    def logged_in?
        !!current_user
    end

    def login(user)
        session[:session_token] = user.reset_session_token!
    end 

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end 

    def logout!
        @current_user.reset_session_token! if logged_in?
        session[:session_token] = nil 
        @current_user = nil 
    end 
end
