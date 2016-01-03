class Car
  PROPERTIES = [:Class, :references, :id, :Description,:Name, :condition]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }
 def initialize (vin=' me?')
         @Name = "apple"
         @condition = "ripe"
	 self.Class=vin

 end


  def self.examples
	return [self.find(001),self.find(002)]

  end



  def self.find(vin)
	return Car.new '1100'+vin.to_s
  end


end

