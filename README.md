# Proto

Proto is a nokogiri wrapper that uses scraping patterns to return value objects with minimal work. 

It is the evolution of [another project](https://github.com/kcurtin/scrape_source).

Proto is meant to be lightweight and flexible, the objects you get back inherit from OpenStruct.  New methods can be dynamically added to the objects, you won't ever get method_missing errors, and you can access the data in a bunch of different ways. Check out the documentation for more info: [OpenStruct](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/ostruct/rdoc/OpenStruct.html)

## Usage

Create a new Scraper object with the URL you want to scrape data from

```ruby
proto = Proto::Scraper.new('http://twitter.com/kcurtin')
```

Initializing a scraper gives you an object with a nokogiri doc based on the URL you provided
```ruby
proto.inspect
#=> #<Proto::Scraper:0x007fc6fb852860 @doc=#<Nokogiri::HTML::Document:0x3fe37d0b1634...>
```

Currently, the API is strict. There is a single public method you can call. This method accepts a constant name and a hash as arguments:
```ruby
tweets = proto.fetch('Tweet', {:name => 'strong.fullname', 
                               :content => 'p.js-tweet-text', 
                               :created_at => 'small.time'})
```
The string you pass in as a constant name will become the class name of the objects you get back. They will be namespaced, so passing in 'Tweet' returns objects of the class ```Proto::Tweet```. If you fail to pass in a constant, your return objects will be of class ```Proto::Type```.

The keys correspond with the getter/setter methods that will be available on the object you get back and should describe the data you want. The values you pass in are css selectors that you need to provide to tell Proto where the data you want lives in the DOM of the page you are scraping.

```.fetch``` returns an array of objects that contain your data:
```ruby 
tweets.inspect
#=> [#<Proto::Tweet name="Kevin Curtin", content="@cawebs06 just a tad over my head... You guys are smart :)", created_at="11h">,
      #<Proto::Tweet name="Kevin Curtin", content="@garybernhardt awesome, thanks. any plans to be in nyc soon? @FlatironSchool would love to have you stop by. we love DAS", created_at="12h">...]
```

OpenStruct features:

```ruby
tweet = tweets.first
#=> #<Proto::Tweet name="Kevin Curtin", content="@cawebs06 just a tad over my head... You guys are smart :)", created_at="11h">

#flexible:
tweet.title
#=> nil

#dynamic:
tweet.username = 'kcurtin'
#=> 'kcurtin'
```

Enjoy!

## Installation

Add this line to your application's Gemfile:

    gem 'proto'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proto


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
