module Proto
  class Tweet < OpenStruct
    def self.fetch_tweets(user_name='kcurtin')
      doc = Nokogiri::HTML(open("http://twitter.com/#{user_name}"))
      selector_hash = default_selectors
      
      args = scrape_attribute_data(doc, selector_hash)
      create_from_scraped_data(user_name, args)
    end

    def self.scrape_attribute_data(doc, selector_hash)
      selector_hash.each_with_object([]) do |(key, selector), obj_data|
        doc.css(selector).each do |el|
          obj_data << { key => el.text.strip }
        end
      end
    end

    def self.default_selectors
      {content: 'p.js-tweet-text', published_at: 'span.js-short-timestamp'}
    end

    def self.create_from_scraped_data(user_name, args)
      args.each do |arg|
        new( user_name: user_name, content: arg.fetch(:content){'test'}, 
             published_at: arg.fetch(:published_at){'nov 1'} )
      end
    end
  end
end