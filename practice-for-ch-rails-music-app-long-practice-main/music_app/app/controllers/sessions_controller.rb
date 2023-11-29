class SessionsController < ApplicationController

    before_action :logged_in?

    def new 
        @user=User.new
        render :new
    end

    def destroy 
        
    end

end
