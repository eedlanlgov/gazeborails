#!/usr/bin/ruby -w

require '../config/environment.rb'


class Record
  
  def initialize(r)
    @thisEntry = r
  end
  
  def insert
    # Result is the central record table (a.k.a model)
    myResult = Result.new
    
    @thisEntry.each_key do |k|
      case k
        
      when "user"
        user = User.find_by_name(@thisEntry['user'])
        unless user
          user = User.new
          user.name = @thisEntry['user']
          user.save
        end
        myResult.user_id = user.id
        
      when "result"
        myResult.result = @thisEntry['result'].eql?("pass") ? 1 : 0
        
      # do nothing yet for these cases, but handle below
      when "nodes"
      when "segname"
      when "td"
        
      else
        eval("myResult.#{k} = @thisEntry[k]")
        
      end
    end
    myResult.save
    
    # now handle cases where a result id is needed
    @thisEntry.each_key do |k|
        case k
        # add a node to node table if not present
        when "nodes"
          tmpArray = @thisEntry[k].split(" ")
          tmpArray.each do |n|
            n.lstrip!
            n.rstrip!
            node = Node.find_by_name(n)
            unless node
              node = Node.new
              node.name = n
              node.save
            end
            # update ndoes_results tbl
            ns = NodesResults.new
            ns.node_id = node.id
            ns.result_id = myResult.id
            ns.save
          end
        
        # add a segment name to segment table if not present
        when "segname"
          tmpArray = @thisEntry[k].split(" ")
          tmpArray.each do |s|
            s.lstrip!
            s.rstrip!
            seg = Segment.find_by_name(s)
            unless seg
              seg = Segment.new
              seg.name = s
              seg.save
            end
            # update into results_segments tbl
            rs = ResultsSegments.new
            rs.result_id = myResult.id
            rs.segment_id = seg.id
            rs.save
          end
          
        when "td"
          tmpArray = @thisEntry[k].split(",")
          tmpArray.each do |t|
            (tdName, tdVal, tdUnits) = t.split(" ")
              tdp.lstrip!
              tdp.rstip!
            # update into trend_datas tbl
            td = TrendData.new
            td.result_id = myResult.id
            td.name = tdName
            td.value = tdVal
            td.units = tdUnits
            td.save
          end
          
          
        end
    puts "done processing result id #{myResult.id}"
  end 
end



# start here, reading key value pairs from gazebo data file
File.open("./gazeboData.txt", "r") do |infile|
  myHash = {}
  while (line = infile.gets)
    line.chomp!
    # empty line separates new records
    if (line.empty?)
      next if myHash.empty?
      puts ""
      puts "--- process new record ---"
      
      nr = Record.new(myHash)
      nr.insert
      myHash.clear
      
    else
      # keep slurping up key/val pairs until there is an empty line
      (key, value) = line.split("::")
      key.lstrip!
      key.rstrip!
      value.lstrip!
      value.rstrip!
      myHash.store(key,value)
    end
  end
end

