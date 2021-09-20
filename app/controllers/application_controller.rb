class ApplicationController < ActionController::Base

    helper_method :current_user

    def login(user)
        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logout!
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end

    def login_user!
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        
        if @user
            login(@user)
            redirect_to cats_url
        else
            render :new
        end
    end

    # def require_logged_in
        
    # end

    def require_logged_out
        redirect_to cats_url if logged_in?
    end

end
