require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Scraper do
  it "accepts a url as arguments" do  
    scrape = Proto::Scraper.new('some_url')
    scrape.url.should == 'some_url'
  end

  context ".go!" do
    let(:scrape) { Proto::Scraper.new('some_url') }
    it "the default class name is 'Proto::Type'" do
      our_obj = scrape.go!({})
      our_obj.class.to_s.should == 'Proto::Type'
    end

    it "accepts a custom class name" do
      our_obj = scrape.go!('Kevin', {})
      our_obj.class.to_s.should == 'Proto::Kevin'
    end

    it "accepts a hash and name and sets custom attrs" do
      our_obj = scrape.go!('Test', {:name => 'Kevin', :title => "Title"})
      our_obj.name.should == 'Kevin'
      our_obj.title.should == 'Title'
    end

    it "accepts only a hash and sets default class name" do
      our_obj = scrape.go!({:name => 'default const'})
      our_obj.class.to_s.should == 'Proto::Type'
    end
  end
end