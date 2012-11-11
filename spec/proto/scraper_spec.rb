require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Scraper do
  it "accepts a url as arguments" do  
    scrape = Proto::Scraper.new('some_url')
    scrape.url.should == 'some_url'
  end

  context ".go!" do
    let(:scrape) { Proto::Scraper.new('some_url') }
    it "accepts a name argument that defaults to 'Proto::Type'" do
      scrape.go!({:hash => 'str'}).should == 'Proto::Type'
    end
  end
end