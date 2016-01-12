require 'test_helper'
class CarHelperTest < ActionView::TestCase

  test "basic unit tests" do
	assert 1+1==2,'basic math test'
	assert Car.find('honda').ReviewerSummary=="Honda's 2013 Accord is more than the sum of its parts -- smooth and comfortable yet never out of its element. Honda has once again hit its stride with a midsize sedan that does everything well and feels like something we'd be happy to drive every day for years.", 'honda review'
	assert_raises(Exception) {  Car.find('test')}
	assert Car.find('1GNDM19W41B138351').model=="Astro", 'my astro'
  end
end
