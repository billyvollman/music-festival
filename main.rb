require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'httparty'

# make an API call
# cycle through the array and find all the Record Labels and make a list of the Record Labels.  The Record Labels list should show the Band Names and what Music Festivals the bands have attended.

# example the data structure I need

  # billy_test = {
  #   'Outerscope' => {
  #       'Squint-281' => [
  #           'Small Night In',
  #           'Twisted Tour'
  #       ],
  #       'Summon' => [
  #           'Twisted Tour'
  #       ]
  #   },
  #   'Marner Sis. Recording' => {
  #       'Green Mild Cold Capsicum' => [
  #           'Small Night In'
  #       ],
  #       'Wild Antelope' => [
  #           'Small Night In'
  #       ],
  #       'Auditones' => [
  #           'Twisted Tour'
  #       ]
  #   }
  # }

# how I will access the final data structure once in the format required

  # billy_test.each {|key, value| puts "Record Label #{key}" 
  #   value.each {|key, value| puts "   Band #{key}"
  #       value.each do |item| 
  #           puts "       venue #{item}" 
  #       end
  #   }
  # }

  # not sure how to handle Too many requests, throttling.  It's not crashing the page but it is also not letting me display no information section.  I'm a little stumped at the moment

get '/' do
  url = "http://eacodingtest.digital.energyaustralia.com.au/api/v1/festivals"
  result = HTTParty.get(url)

  # using this to log in terminal the result.code trying to sort out throttling
  case result.code
  when 200
    puts "All good!"
  when 429
    puts "Throttled"
    # hoping to redirect to index with no information message when throttling is on but not working
    @record_labels_hash = 'No information at the moment throttling'
    # binding.pry
    @result = "Too many requests, throttling"
    erb :index
  when 400...600
    puts "ZOMG ERROR #{result.code}"
    @record_labels_hash = 'No information at the moment throttling'
    erb :index
  end

  
  record_labels = []
  bands = []
  music_festival = []

  if result[0] == nil 
    # binding.pry
    @record_labels_hash = 'No information'
    erb :index
  else   

  if result[0] == "T"
    # binding.pry
    # hoping to redirect to index with no information message when throttling is on but not working here either.
    # I setup a series of binding.pry to see where things were flowing when 429 result.code happened
    # it would not go where I wanted it to
    @record_labels_hash = 'No information'
    erb :index
  end
  
    # binding.pry

  for i in result do 

      if i['name'] == false
        puts 'not working'
      end 

      if i['name']
          music_festival << i['name']
      end

      if i['bands']
        i['bands'].each do |band| 
          bands << band['name']
          if band['recordLabel'] != '' && band['recordLabel'] != nil
            record_labels << band['recordLabel'] 
          end
        end
      end

      if i['bands'] == false
        @record_labels_hash = 'No information'
        erb :index
      end

  end

  record_labels_sorted_array = record_labels.uniq.sort
  unique_bands = bands.uniq.sort

  @record_labels_hash = {

  }

  record_labels_sorted_array.each do |record_label| 
    @record_labels_hash[record_label] = {}

    for i in result do 
      i['bands'].each do |band| 
        if band['recordLabel'] != '' && band['recordLabel'] != nil && band['recordLabel'] == record_label 
          @record_labels_hash[record_label][band['name']] = []
        end
      end
    end


      unique_bands.each do |unique_band|
        for i in result do
          i['bands'].each do |band| 
            if band['name'] == unique_band && @record_labels_hash[record_label][band['name']] != nil
              if i['name'] != nil 
                @record_labels_hash[record_label][band['name']] << i['name']
                # trying to sort the array of music festivals each band has been to, alphabetically
                # does not seem like I needed it based on data
                # @record_labels_hash[record_label][band['name']].sort!
              end   
            end
          end
        end
      end
  end


  @record_labels_hash.each do | key, value |
      @record_labels_hash[key] = @record_labels_hash[key].sort.to_h
  end
  


  erb :index
end
end