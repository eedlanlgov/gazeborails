# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Pick a unique cookie name to distinguish our session data from others'

  before_filter :authorize, :only => [:chart]

  session :session_key => '_' + Time.now.hash.abs.to_s + '_gazebo_session_id'
  
  private
  def authorize
  	unless User.find_by_id(session[:user_id])
  	  session[:original_uri] = request.request_uri
  	  redirect_to(:controller => "login", :action => "login")
          flash[:notice] = "Please log in"
  	  return false
  	end
  end
  
end
