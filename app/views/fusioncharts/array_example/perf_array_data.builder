#Creates xml with values for performance data of tests along with their names.

#The values required for building the xml as obtained as parameter performance_data
#It expects an array in which each element is 
#itself an array with first element as label and second element as value

xml = Builder::XmlMarkup.new
xml.chart(:caption=>'Average Run Time', :xAxisName=>'Test Name', :yAxisName=>'Seconds', :labelDisplay=>'ROTATE', :slantLabels=>'1', :formatNumberScale=>'0') do
	for item in arr_data
		xml.set(:label=>item[0], :value=>item[1])
	end
end
