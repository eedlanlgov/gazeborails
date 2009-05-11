#!/usr/bin/ruby -w

require '../config/environment.rb'

class SegmentData
  
  def popSegUserTbl
     segUser = [] 
     rs = ResultsSegments.find(:all)
     rs.each do |r|
        begin
          result = Result.find(r.result_id)
          #puts "testid: #{r.result_id}, segId: #{r.segment_id}, userId: #{result.user_id}"
          unless (segUser.include?({:segment=>r.segment_id, :user=>result.user_id}))
            segUser << {:segment=>r.segment_id, :user=>result.user_id}
          end
        rescue
          puts "didn't find a test with that id #{r.result_id}"
        end
     end
     segUser.each do |su|
       sut = SegmentsUsers.new
       sut.user_id = (su[:user])
       sut.segment_id = (su[:segment])
       sut.save
       user = User.find(su[:user]).name
       seg = Segment.find(su[:segment]).name
       puts "user: #{user} segment: #{seg}"
       #puts "segment#{su[:segment]}"
       #puts "user#{su[:user]}"
     end
  end
  
  
  def getSegs(user = "afn")
    @seg_data = []
    # get user object
    u = User.find_by_name(user)
    # get all tests used by this user
    tests = u.results
    # now for each test determine what segments were used
    tests.each do |t|
      segs = t.segments
      segs.each do |s|
        unless (@seg_data.include?(s.name))
          @seg_data << s.name
        end
      end
    end
  end
 
end

sd = SegmentData.new
sd.popSegUserTbl
puts "I'm done"
 
 

