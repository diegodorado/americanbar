class ApplicationController < ActionController::Base
  before_filter :require_user
  helper :all
  protect_from_forgery  
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation


  ActiveScaffold.set_defaults do |config|
    config.actions = [:create, :list, :search, :show, :update, :delete, :nested, :subform]
    #config.update.link.label "Editar"
  end
  ActiveScaffold::DataStructures::Column.show_blank_record = false

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        redirect_to '/login'
        return false
      end
    end
      
end
