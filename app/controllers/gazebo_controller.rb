class GazeboController < ApplicationController
  layout "auth"

  def chart
    u = User.find_by_id(session[:user_id])
    @user_name = User.find_by_id(session[:user_id]).name
    
    # find all segments relevant to this user
    @seg_names = ["select a segment"]
    sns = u.segments.find(:all)
    sns.each do |s|
      @seg_names << s.name
    end
    
    # find all test case names and trend data relevant to this user
    @testcase_names = ["select a test case"]
    ipr = u.results.find(:all)  # results for this user
    ipr.each do |r|
      @testcase_names << r.name
    end
    @testcase_names = @testcase_names.uniq
    
    # initial set of trend data pertains to default test case selection
    #   refine set when user specifies a test case
    @trenddata_names = ["select trend data"]
    tds = Trend_data.find(:all)
    tds.each do |t|
      #tds = Trend_data.find :all, :conditions => "result_id = #{r.id} AND name = '#{type}'"
      #tds = Trend_data.find :all, :conditions => "result_id = #{r.id} AND name = '#{tn}' "
      @trenddata_names << t.name
    end
    @trenddata_names = @trenddata_names.uniq
    
    # Chart formats and displays
    @chart_formatnames = [ 'select graph subject', 'Run Time', 'Trend Data' ]
    @chart_displaynames = [ 'select graph style', 'Column' , 'Line' ]
  
  end
  
  def setup
  end
  
  def about_us
  end
  
  def contact
  end
  
  def create
  	@chart = Chart.create(params[:chart])
  	redirect_to :controller => 'gazebo',
  	            :action     => 'chart',
  	            :id         => @chart.id
  end
  
  def do_generate
    flash[:notice] = "You just pressed the button!"
  #  if request.post?
  #    chart = Chart.create(params[:testcase], params[:trenddata], params[:charttype])
  #    if chart
  #	redirect_to(:action => "show")
  #    end
  #  end
  end
  
  def reset_options
    flash[:notice] = "Configuration options have been reset"
    redirect_to(:controller => 'gazebo', :action => 'chart')
  end

end