require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Scraper do
  it 'returns my objects!' do
    obj = Proto::Scraper.new('https://twitter.com/kcurtin')
    obj_collection = obj.fetch('Tweet', { :name => 'strong.fullname',
                                          :content => 'p.js-tweet-text',
                                          :created_at => 'small.time' }
                              )
    obj_collection.first.class.to_s.should == 'Proto::Tweet'
    obj_collection.first.name.should == 'Kevin Curtin'
  end

  it "sets its doc attr to a nokogiri doc based on url" do
    expect {
      Proto::Scraper.new('blah_url')
    }.to raise_error(Errno::ENOENT)
  end

  it 'can collect a bunch of urls' do
    obj = Proto::Scraper.new('http://jobs.rubynow.com/')
    obj.collect_urls('ul.jobs li h2 a:first')
    obj.url_collection.first.should =~ /http:\/\/jobs/
  end

  it "should create the objects this way too" do
    obj = Proto::Scraper.new('http://jobs.rubynow.com/')
    obj.collect_urls('ul.jobs li h2 a:first')
    jobs = obj.fetch({  :title => 'h2#headline',
                        :company => 'h2#headline a',
                        :location => 'h3#location',
                        :type => 'strong:last',
                        :description => 'div#info' }
                      )
    jobs.first.class.to_s.should == 'Proto::Type'
    jobs.first.title.should =~ /Ruby/
  end

  it "should work with pagination" do
    obj = Proto::Scraper.new('http://www.mediauk.com/radio/starting-with/a')
    obj.collect_urls('http://www.mediauk.com', 'div.pages a', 'div.columns a')
    puts obj.url_collection.inspect
    obj.url_collection.length.should == 10
  end
end
