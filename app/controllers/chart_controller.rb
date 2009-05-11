class ChartController < ApplicationController
  layout "auth"
  
  def new
    @chart = Chart.new
  end
  
  def create
    @chart = Chart.create(params[:chart])
    redirect_to :controller => 'chart',
                :action     => 'show',
                :id         => @chart.id
  end
  
  def show
    @chart = Chart.find(params[:id])
  end
  
  def index
  end
  
  def config
  end
  
  def plot
  end
  
  # collect average runtime for all tests for a given user
  def avgRunTimePerTest(user = "gazebo")
    headers["content-type"]="text/html";
    total = {}
    count = {}
    avg = 0
    
    # create the list the view will use with a literal array constructor
    @performance_data = []
    
    #Get data from results table
    u = User.find_by_name(user)
    results = u.results.find(:all)
    results.each do |res|
      (real, user, sys)  = res.duration.split(",");
      (type, val ) = real.split(":=")
      if (total.has_key?(res.name))
        total[res.name] += val.to_f
        count[res.name] += 1
      else
        total[res.name] = val.to_f
        count[res.name] = 1
      end
    end
    
    # Push the values into the list
    total.each do |key,value|
      avg = value / count[key]
      # finally, list with testName/val pairs
      @performance_data << [ key, avg.to_i ]
    end
  end


  # plot trend data for this user, testname, and td type
  def plotTd(user = "gazebo", tn = "iperfV", type = "maxRate")
    headers["content-type"]="text/html";
    @td_data  = []
    @td_caption = tn + ":" +  type
    u = User.find_by_name(user)
    ipr = u.results.find_all_by_name(tn)
    ipr.each do |r|
      tds = TrendData.find :all, :conditions => "result_id = #{r.id} AND name = '#{type}'"
      tds.each do |t|
        @td_data << [ r.entrytime, t.value, t.units, r.jobid ]
      end
    end
  end

end
