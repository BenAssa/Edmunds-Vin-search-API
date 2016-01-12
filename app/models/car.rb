class Car
  PROPERTIES = [:StyleName, :Year, :Make, :AvgConsumerRating,:ReviewerSummary, :MPGHighWay, :MPGCity,:EngineType,:vin,:model]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }
  require 'open-uri'  
  def initialize (vin)

 #honda is a special test case for the summary, other parts are not expected to work for the Honda test case
	if vin.length!=17 and vin!='honda'
		raise  "VIN must be 17 digits"
	end
	api_key=Rails.application.secrets.edmunds_api_key
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
		self.model=basicDetails['model']['name']
		self.StyleName=basicDetails['years'][0]['styles'][0]['name']
		self.Year=basicDetails['years'][0]['year']
		self.Make=basicDetails['make']['name']
		self.MPGHighWay=basicDetails['MPG']['highway']
		self.MPGCity=basicDetails['MPG']['city']
	rescue => e 
		puts  e.message.to_s
	end	

	begin
		self.ReviewerSummary=JSON.parse( open("http://api.edmunds.com/api/vehicle/v2/styles/"+styleID.to_s+"/grade?fmt=json&api_key="+api_key).read)['summary']
	rescue => e 
		puts  e.message.to_s
	end	

	begin
	if (self.ReviewerSummary==nil)
		self.ReviewerSummary =JSON.parse(open("http://api.edmunds.com/v1/content/editorreviews?make="+self.Make+"&model="+self.model+"&year="+self.Year.to_s+"&fmt=json&api_key="+api_key).read)['editorial']['review']
	end

	rescue => e 
		puts  e.message.to_s
	end

	begin
		customerReview=JSON.parse(open("http://api.edmunds.com/api/vehiclereviews/v2/styles/"+styleID.to_s+"?sortby=created%3ADESC&pagenum=1&pagesize=5&fmt=json&api_key="+api_key).read)
		if (customerReview!=nil)
			self.AvgConsumerRating=customerReview["averageRating"]
		end
	rescue => e 
		puts  e.message.to_s
	end	
  end


  def self.examples
	return [self.find('1GNDM19W41B138351'),self.find('honda')]
  end



  def self.find(vin)
	return Car.new vin.to_s
  end


end

