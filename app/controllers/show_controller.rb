class ShowController < ApplicationController

  # Get test data from results table for this user and jid
  def testRecordByJobId(user = "gazebo", jid= 27592) 
    headers["content-type"]="text/html";
    @results_data = []
    u = User.find_by_name(user)
    rd = u.results.find_by_jobid(jid)
    td = rd.trend_datas
    rd.attributes.each do |key,value| 
      @results_data << "#{key}: #{value}"
    end
    td.each do |t|
      @results_data << "#{t.name} #{t.value} #{t.units}"
    end
  end

  # get all the trend data types available for this user and test
  # over this date/time range
  def tdTypesForTest(user = "gazebo", tn = "iperfV", oldestTime = 3.years.ago, newestTime = Time.now)
    headers["content-type"]="text/html";
    @td_types = []
    u = User.find_by_name(user)
    ipr = u.results.find_all_by_name(tn , :select => "id", :conditions => {:entrytime => oldestTime..newestTime})
    #ipr = u.results.find_all_by_name(tn , :select => "id", :conditions => {:entrytime => oldestTime..newestTime, :include => :trend_datas})
    ipr.each do |r|
      tds = TrendData.find(:all, :conditions => {:result_id => r.id})
      tds.each do |t|
        unless (@td_types.include?(t.name))
          @td_types <<  t.name
        end
      end
    end
  end

  # get all the test names available to this user over this date/time range
  def testNamesForUser(user = "gazebo", oldestTime = 3.years.ago, newestTime = Time.now)
    headers["content-type"]="text/html";
    @t_names = []
    u = User.find_by_name(user)
    tn = u.results.find_all_by_user_id(u.id, :select => 'DISTINCT name', :conditions => {:entrytime  => oldestTime..newestTime})
   tn.each do |t|
       @t_names <<  t.name
    end
  end

  # get all the segments available
  def segments
    headers["content-type"]="text/html";
    @segment_data = [] 
    #Get data from segments table
    segs = Segment.find(:all)
    segs.each do |s| 
      # fill the hash 
      @segment_data<<{:segment_name=>s.name, :segment_id=>s.id}
    end
  end

  # get all the segments used by a user 
  def segmentsByUser(user="gazebo")
    headers["content-type"]="text/html";
    @segment_data = []
    # get user object 
    u = User.find_by_name(user)
    su = SegmentsUsers.find_all_by_user_id(u.id)
    su.each do |s|
      sn = Segment.find(s.segment_id)
      @segment_data << sn.name
    end
  end


  # get all the nodes used by this test
  # uniquness determined by test name and jobid in this case
  def nodesUsedByTest(name = "iperfV", jobId = 17476)
    headers["content-type"]="text/html";
    @node_data = []
    res = Result.find_by_name_and_jobid(name,jobId)
    res.nodes.each do |n|     
      # Push the hash of values into the array
      @node_data<<{:node_name=>n.name,:node_id=>n.id}
    end

  end

end
