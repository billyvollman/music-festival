require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'httparty'

get '/' do
  url = "http://eacodingtest.digital.energyaustralia.com.au/api/v1/festivals"
  result = HTTParty.get(url)

  # using this to log in terminal the result.code trying to sort out throttling
  case result.code
  when 200
    puts "All good!"
  when 429
    puts "Throttled"
    @result = "Too many requests, throttling"
    erb :index
  end

  if result[0] == nil 
    @result = 'No information'
    erb :index
  end  
  
  record_labels = []
  bands = []
  music_festival = []

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