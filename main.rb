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


result = [
  {
      "name"=> "LOL-palooza",
      "bands"=> [
          {
              "name"=> "Frank Jupiter",
              "recordLabel"=> "Pacific Records"
          },
          {
              "name"=> "Jill Black",
              "recordLabel"=> "Fourth Woman Records"
          },
          {
              "name"=> "Winter Primates",
              "recordLabel"=> ""
          },
          {
              "name"=> "Werewolf Weekday",
              "recordLabel"=> "XS Recordings"
          }
      ]
  },
  {
      "name"=> "Small Night In",
      "bands"=> [
          {
              "name"=> "The Black Dashes",
              "recordLabel"=> "Fourth Woman Records"
          },
          {
              "name"=> "Yanke East",
              "recordLabel"=> "MEDIOCRE Music"
          },
          {
              "name"=> "Squint-281",
              "recordLabel"=> "Outerscope"
          },
          {
              "name"=> "Green Mild Cold Capsicum",
              "recordLabel"=> "Marner Sis. Recording"
          },
          {
              "name"=> "Wild Antelope",
              "recordLabel"=> "Marner Sis. Recording"
          }
      ]
  },
  {
      "name"=> "Trainerella",
      "bands"=> [
          {
              "name"=> "Manish Ditch",
              "recordLabel"=> "ACR"
          },
          {
              "name"=> "YOUKRANE",
              "recordLabel"=> "Anti Records"
          },
          {
              "name"=> "Adrian Venti",
              "recordLabel"=> "Monocracy Records"
          },
          {
              "name"=> "Wild Antelope",
              "recordLabel"=> "Still Bottom Records"
          }
      ]
  },
  {
      "name"=> "Twisted Tour",
      "bands"=> [
          {
              "name"=> "Summon",
              "recordLabel"=> "Outerscope"
          },
          {
              "name"=> "Squint-281"
          },
          {
              "name"=> "Auditones",
              "recordLabel"=> "Marner Sis. Recording"
          }
      ]
  },
  {
      "bands"=> [
          {
              "name"=> "Propeller",
              "recordLabel"=> "Pacific Records"
          },
          {
              "name"=> "Critter Girls",
              "recordLabel"=> "ACR"
          }
      ]
  }
]

get '/' do
  

  # url = "http://eacodingtest.digital.energyaustralia.com.au/api/v1/festivals"
  # result = HTTParty.get(url)

  record_labels = []
  bands = []
  music_festival = []

  for i in result do 
      if i['name']
          music_festival << i['name']
      end

      i['bands'].each do |band| 
          bands << band['name']
          if band['recordLabel'] != '' && band['recordLabel'] != nil
              record_labels << band['recordLabel'] 
          end
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



  # record_labels_hash.each {|key, value| puts "Record Label #{key}" 
  #     value.each {|key, value| puts "   Band #{key}"
  #         value.each do |item| 
  #             puts "       venue #{item}" 
  #         end
  #     }
  # }
  


  erb :index
end





