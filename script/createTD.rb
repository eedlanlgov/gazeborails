#!/usr/bin/ruby -w

# this script takes the gazeboData text file and populates the trend_datas table
require '../config/environment.rb'


class Record
  
  def initialize(r)
    @thisEntry = r
  end
  
  def insert
    # Result is the central record table (a.k.a model)
    
    @thisEntry.each_key do |k|
      case k

      when "jobid"
        r = Result.find_by_jobid(@thisEntry['jobid'])
        if (r) 
          @thisId = r.id
        else
          return
        end
        
      when "td"
          tmpArray = @thisEntry[k].split(",")
          tmpArray.each do |t|
            t.lstrip!
            t.rstrip!
            (tdName, tdVal, tdUnits) = t.split(" ")
            # update into trend_datas tbl
            td = TrendData.new
            td.result_id = @thisId
            td.name = tdName
            td.value = tdVal
            td.units = tdUnits
            td.save
            #puts "insert name=>#{tdName} value=>#{tdVal} units=>#{tdUnits}"
          end
      end
      
    end
         puts "done processing result id #{@thisId}"
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

