require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Scraper do
  it "sets its doc attr to a nokogiri doc based on url" do
    expect { 
      Proto::Scraper.new('blah_url')
    }.to raise_error(Errno::ENOENT)
  end
 
 # Nokogiri::HTML.any_instance_of.returns
 
  context ".go!" do
    before(:each) do
      Nokogiri::HTML.stub!(:open).and_return("doc")
      Nokogiri::HTML::Document.stub!(:parse)
      Nokogiri::HTML::Document.should_receive(:parse).and_return('str')
    end

    let(:scrape) { Proto::Scraper.new('http://example.com') }

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