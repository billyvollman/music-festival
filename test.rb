
require 'pry'

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

# how you get the first one
# result[0][:bands][0][:recordLabel]

# for i in result do 
#     puts i 
# end

# for i in result do 
#     puts i[:bands] 
# end

# for i in result do 
#     i[:bands].each do |band| 
#         puts band[:recordLabel] 
#     end 
# end

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


# for i in result do 
#     if i['name']
#         music_festival << i['name']
#     end
# end

# for i in result do 
#     i['bands'].each do |band| 
#         bands << band['name']
#     end
# end

# for i in result do 
  
#     i['bands'].each do |band| 
#       if band['recordLabel'] != '' && band['recordLabel'] != nil
#             record_labels << band['recordLabel'] 
#       end
#     end
  
# end

# for i in result do 
#     i[:bands].each do |band| 
#         if band[:recordLabel] == '' 
#             band[:recordLabel] = 'Does not have record label'
#             record_labels << band[:recordLabel] 
#         else 
#             record_labels << band[:recordLabel] 
#         end 
#     end
# end

record_labels_sorted_array = record_labels.uniq.sort
unique_bands = bands.uniq.sort

record_labels_hash = {

}

record_labels_sorted_array.each do |record_label| 
   record_labels_hash[record_label] = {}

   for i in result do 
        i['bands'].each do |band| 
            if band['recordLabel'] != '' && band['recordLabel'] != nil && band['recordLabel'] == record_label 
                record_labels_hash[record_label][band['name']] = []
            end
        end
    end


    unique_bands.each do |unique_band|
        for i in result do
            i['bands'].each do |band| 
                if band['name'] == unique_band && record_labels_hash[record_label][band['name']] != nil
                    if i['name'] != nil 
                        record_labels_hash[record_label][band['name']] << i['name']
                        record_labels_hash[record_label][band['name']].sort!
                    end   
                end
            end
        end
    end

end

billy_test = {

}
record_labels_hash.each do | key, value |
    record_labels_hash[key] = record_labels_hash[key].sort.to_h
end


record_labels_hash['ACR'].sort.to_h



record_labels_hash.each {|key, value| puts "Record Label #{key}" 
    value.each {|key, value| puts "   Band #{key}"
        value.each do |item| 
            puts "       venue #{item}" 
        end
    }
}



unique_bands.each do |bandz|
    for i in result do
        i['bands'].each do |band| 
            if band['name'] == bandz
                if i['name'] != nil 
                    record_labels_hash[record_label][band['name']] << i['name']
                end   
            end
        end
    end
end



record_labels_hash['ACR']['Squint-281'] = []
record_labels_hash['ACR']['Squint-281'] << 'Small Night In'

for i in result do 
    i['bands'].each do |band| 
      if band['recordLabel'] != '' && band['recordLabel'] != nil
            record_labels_hash[band['recordLabel']] = band['name']
      end
    end
end

billy_test = {
    'Outerscope' => {
        'Squint-281' => [
            'Small Night In',
            'Twisted Tour'
        ],
        'Summon' => [
            'Twisted Tour'
        ]
    },
    'Marner Sis. Recording' => {
        'Green Mild Cold Capsicum' => [
            'Small Night In'
        ],
        'Wild Antelope' => [
            'Small Night In'
        ],
        'Auditones' => [
            'Twisted Tour'
        ]
    }

}


# for i in result do 
#     i['bands'].each do |band| 
#       if band['recordLabel'] != '' && band['recordLabel'] != nil
#             record_labels_hash[band['recordLabel']] = band['name']
#       end
#     end
# end

record_labels_sorted_array.each do |record_label| 
    puts 'Record Label ' + record_label

    for i in result do 

        i['bands'].each do |band| 
          if band['recordLabel'] != '' && band['recordLabel'] != nil && band['recordLabel'] == record_label 
            if i['name'] == nil 
                puts ' ' + band['name']
            elsif i['name'] != nil 

                puts ' ' + band['name']
                puts '    ' + i['name']
            end   
          end
        end
    end
    puts ""
end

binding.pry



billy_test = [
    'Outerscope' => {
        'Squint-281' => [
            'Small Night In',
            'Twisted Tour'
        ]
    }
]

billy_test.each do |label|
    puts label.keys 
end

# the data structure I need

billy_test = {
    'Outerscope' => {
        'Squint-281' => [
            'Small Night In',
            'Twisted Tour'
        ],
        'Summon' => [
            'Twisted Tour'
        ]
    },
    'Marner Sis. Recording' => {
        'Green Mild Cold Capsicum' => [
            'Small Night In'
        ],
        'Wild Antelope' => [
            'Small Night In'
        ],
        'Auditones' => [
            'Twisted Tour'
        ]
    }

}

# how I will access the data structure once in the format required

billy_test.each {|key, value| puts "Record Label #{key}" 
    value.each {|key, value| puts "   Band #{key}"
        value.each do |item| 
            puts "       venue #{item}" 
        end
    }
}

# the hash sorted based on keys and in a hash

billy_test_sorted = billy_test.sort.to_h

billy_test_sorted.each {|key, value| puts "Record Label #{key}" 
    value.each {|key, value| puts "   Band #{key}"
        value.each do |item| 
            puts "       venue #{item}" 
        end
    }
}