require 'test_helper'

class CarsControllerTest < ActionController::TestCase
 

  test "shouldbe succesful" do
  	get(:show, {'id' => "1GNDM19W41B138351"}    )	  
  	assert_response :success
  end

  test "should return the correct make for my van" do
  	get(:show, {'id' => "1GNDM19W41B138351"}    )
    	body = JSON.parse(response.body)
    	assert  body["Make"] =='Chevrolet'
  end

   # body = JSON.parse(response.body)
   # assert_equal "Some returned value", body["ReviewerSummary"]
end
