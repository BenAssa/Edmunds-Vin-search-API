This program gets a JSON of a given VIN using the following call
http://domain/cars/VIN
for example
http://localhost:8080/cars/1GNDM19W41B138351
The provided JSON fields are 
 :Year, :Make, :AvgConsumerRating,:ReviewerSummary, :MPGHighWay, :MPGCity,:EngineType,:vin,:model
The system runs on Rails '4.2.5',  and a supporting Ruby
the bundle install will get the Rails and other gems working on a system that has Bundle, and Ruby already installed
The system assumes, there alraedy is an environment variable called EDMUNDS_API which includes the API
