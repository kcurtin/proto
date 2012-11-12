require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Scraper do
  before(:each) do
    Nokogiri::HTML.stub!(:open).and_return("doc")
    Nokogiri::HTML::Document.stub!(:parse)
    @scrape = Proto::Scraper.new('http://example.com')
    @scrape.stub_chain(:doc, :css, :text).and_return('STUBBED OUT')
  end
  
  it "sets its doc attr to a nokogiri doc based on url" do
    expect { 
      Proto::Scraper.new('blah_url')
    }.to raise_error(Errno::ENOENT)
  end

  context ".fetch_and_create!" do
    it "the default class name is 'Proto::Type'" do
      our_obj = @scrape.fetch_and_create!({})
      our_obj.class.to_s.should == 'Proto::Type'
    end

    it "accepts only a hash and sets default class name" do
      our_obj = @scrape.fetch_and_create!({:name => 'default const'})
      our_obj.class.to_s.should == 'Proto::Type'
    end

    it "returns a Proto object with attributes set" do
      our_obj = @scrape.fetch_and_create!('Sample', {:name => "Kevin", :title => "Developer"})
      our_obj.name.should == "STUBBED OUT"
      our_obj.title.should == "STUBBED OUT"
      our_obj.class.to_s.should == "Proto::Sample"
    end
  end

  context 'private methods' do
    context ".create_return_objects" do
      it "accepts a custom class name" do
        our_obj = @scrape.send(:create_return_objects, 'Kevin', {})
        our_obj.class.to_s.should == 'Proto::Kevin'
      end

      it "accepts a hash and name and sets custom attrs" do
        our_obj = @scrape.send(:create_return_objects, 'Test', {:name => 'Kevin', :title => "Title"})
        our_obj.name.should == 'Kevin'
        our_obj.title.should == 'Title'
      end
    end

    context ".scrape_attribute_data" do
      it "returns a hash of stuff" do
        rh = @scrape.send(:scrape_attribute_data, {:title => "h2 a"})
        rh.should == {:title => 'STUBBED OUT'}
      end
    end
  end
end