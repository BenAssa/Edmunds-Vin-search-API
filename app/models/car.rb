class Car
  PROPERTIES = [:Name, :Year, :Make, :AvgConsumerRating,:ReviewerSummary, :MPGHighWay, :MPGCity,:EngineType,:vin]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }
 require 'open-uri'  
 def initialize (vin='honda')
	 api_key=Rails.application.secrets.edmunds_api_key
	 puts "http://api.edmunds.com/api/vehicle/v2/styles/200434856?view=full&fmt=json&api_key="+api_key
	 self.vin=vin
 	 #I prefer to use names over nice names, and don't expect any problems with the tech used
	if (vin=='honda')
 		basicDetails=JSON.parse(open("http://api.edmunds.com/api/vehicle/v2/styles/200434856?view=full&fmt=json&api_key="+api_key).read)
		styleID='200434856'
	else
 		basicDetails=JSON.parse(open("http://api.edmunds.com/api/vehicle/v2/vins/"+vin.to_s+"?fmt=json&api_key="+api_key).read)
		styleID= basicDetails['years'][0]['styles'][0]['id']
		
	end
begin

	self.EngineType=basicDetails['engine']['type']		
	self.Name=basicDetails['years'][0]['styles'][0]['name']
	self.Year=basicDetails['years'][0]['year']
	self.Make=basicDetails['make']['name']
	self.MPGHighWay=basicDetails['MPG']['highway']
	self.MPGCity=basicDetails['MPG']['city']
	## style info =https://api.edmunds.com/api/vehicle/v2/styles/200434856/grade?fmt=json&api_key="+api_key
	#NEEDS TESTING
	#
	#
	#
	#
	rescue Exception 
		puts 'error 101 '+ vin
	end
	begin


	profReview=JSON.parse( open("http://api.edmunds.com/api/vehicle/v2/styles/"+styleID.to_s+"/grade?fmt=json&api_key="+api_key).read)
	if (profReview!=nil)
		self.ReviewerSummary =profReview['summary']
	end

rescue Exception 
end	
	begin

	customerReview=JSON.parse(open("http://api.edmunds.com/api/vehiclereviews/v2/styles/"+styleID.to_s+"?sortby=created%3ADESC&pagenum=1&pagesize=5&fmt=json&api_key="+api_key).read)
	if (customerReview!=nil)
		self.AvgConsumerRating=customerReview["averageRating"]
	end
	rescue Exception 
end	
 end


  def self.examples
	return [self.find('1GNDM19W41B138351'),self.find('honda')]

  end



  def self.find(vin)
	return Car.new vin.to_s
  end


end

