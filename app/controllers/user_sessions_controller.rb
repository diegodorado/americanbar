class UserSessionsController < ApplicationController
  before_filter :require_user, :only => :destroy
  layout "login"
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to '/'
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
      redirect_to '/login'
  end
end

