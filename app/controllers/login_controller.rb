class LoginController < ApplicationController
	
  layout "unauth"
  
  before_filter :authorize, :except => :login
  
  def index
    render :action => 'login'
  end
  
  
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:pw])
      if user
  	session[:user_id] = user.id
  	session[:user_name] = params[:name]
  	#session[:session_key] = '_' + Time.now.hash.abs.to_s + '_gazebo_session_id'
  	uri = session[:original_uri]
  	session[:original_uri] = nil
  	
  	# set global variable for user name here
  	#$user_name = params[:name]
  	flash[:notice] = "user " + params[:name] + " logged in"
  	redirect_to(uri || { :controller => 'gazebo', :action => 'chart'})
      else
  	flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "user " + params[:name].to_s + " logged out"
    session[:user_name] = nil
    redirect_to(:controller => 'login', :action => 'login')
  end
  
end