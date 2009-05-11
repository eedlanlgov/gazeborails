#Creates xml with values for trend data of tests along with their names.

#The values required for building the xml as obtained as parameter performance_data
#It expects an array in which each element is 
#itself an array with first element as label and second element as value

xml = Builder::XmlMarkup.new
xml.chart(:caption=>@td_caption, :xAxisName=>'time when test completed', :yAxisName=>'MB/sec', :labelDisplay=>'ROTATE', :yAxisMinValue=>'220', :labelStep=>'15', :showValues=>'0') do
	for item in arr_data
                toolTip = "#{item[1]}, jobid: #{item[3]}"
		xml.set(:label=>item[0], :value=>item[1], :toolText=>toolTip)
	end
end
