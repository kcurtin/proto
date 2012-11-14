# Proto

Proto lets you create highly malleable, disposable value objects. You create a Proto::Scraper object with a URL. You can then pass it the name of the class you want back and a hash with the attributes and selectors so that it knows which data to scrape for you. The objects you get back are OpenStructs and are very flexible.

## Installation

Add this line to your application's Gemfile:

    gem 'proto'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proto

## Usage

```ruby

proto = Proto::Scraper.new('http://twitter.com/kcurtin')

@tweets = proto.fetch_and_create!('Tweet', {:name => 'strong.fullname', 
                                               :content => 'p.js-tweet-text', 
                                               :created_at => 'small.time' })

#by default, Proto::Scraper only returns 10 objects
 
@tweets.inspect
#<Proto::Tweet name="Kevin Curtin", content="@cawebs06 just a tad over my head... You guys are smart :)", created_at="11h">
#<Proto::Tweet name="Kevin Curtin", content="@garybernhardt awesome, thanks. any plans to be in nyc soon? @FlatironSchool would love to have you stop by. we love DAS", created_at="12h">...

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
