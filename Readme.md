## Link to web app
Click link here: [Music Festival](https://music-festival.herokuapp.com)

## About this web app

Purpose of web app is to list out music festival data in a particular manner: at the top level, it should show the band record label, below that it should list out all bands under their management, and below that it should display which festivals they've attended, if any. All entries should be sorted alphabetically.

**For example:**
```
Record Label 1
  Band X
    Omega Festival
  Band Y
Record Label 2
  Band A
    Alpha Festival
    Beta Festival
```

The data is provided to me via an API.

## How I approached this problem

I needed to figure out which technology and language to use to make an API call.  I decided to use Ruby using Sinatra and httparty.  After I made that decision I went about creating my folder for repo and the necessary files.  I also required necessary gems.

I made my first API call to ensure everything was setup correctly.  Once it was I moved onto analysing the existing data structure in the API.  After analysing the data structure I then decided to focus on being able to access the information I needed.  When I was satisfied I could access the data correctly, I then focused on what structure I wanted to put this data into so I could finally loop through the data to then present it on a webpage.  Below are examples of the data structure I wanted to create and the code I planned to use to loop through the final data structure.

Once I had my data structure sorted and was able to loop through everything via the console, I then went about displaying it on a web page and gave the data a little bit of CSS love.  

**Example of final data structure created**
```

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
```

**Example of how I loop through final data structure to present on webpage**

```
billy_test.each {|key, value| puts "Record Label #{key}"
    value.each {|key, value| puts "   Band #{key}"
        value.each do |item|
            puts "       venue #{item}"
        end
    }
}
```

## Technologies used

- Ruby
- Gems used:
    - pry
    - sinatra
    - sinatra/reloader
    - httparty

## Challenges

Through that process I ran into some error handling issues.

I had to rethink my logic to sort out when the page returned a 429 code for "Too Many Requests" or when there was certain data missing from the original dataset.  The 429 code is still a challenge at the moment as are the instances where no data is available from the API.  These issues are no longer crashing my site but I would like to present better error messaging and information on the page to inform users of what is going on.  This is an area I have not had much experience in so am looking into learning more about this.

**Update**:

Have worked out how to better handle errors caused the API responding with an empty array or with a 429 code.  Individual messages are now being displayed.
