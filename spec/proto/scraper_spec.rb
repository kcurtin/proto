require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Scraper do
  before(:each) do
    # Nokogiri::HTML.stub!(:open).and_return("doc")
    # Nokogiri::HTML::Document.stub!(:parse)
    # @scrape = Proto::Scraper.new('http://example.com')
    # @scrape.stub_chain(:doc, :css, :each).and_return('STUBBED OUT')
  end

  it 'returns my objects!' do
    obj = Proto::Scraper.new('https://twitter.com/kcurtin')
    obj_collection = obj.fetch('Tweet', { :name => 'strong.fullname',
                                            :content => 'p.js-tweet-text', :created_at => 'small.time' })
    # obj_collection.length.should == 10
    obj_collection.first.class.to_s.should == 'Proto::Tweet'
    obj_collection.first.name.should == 'Kevin Curtin'
  end

  it "sets its doc attr to a nokogiri doc based on url" do
    expect {
      Proto::Scraper.new('blah_url')
    }.to raise_error(Errno::ENOENT)
  end
  # context ".fetch" do
  #   it "the default class name is 'Proto::Type'" do
  #     our_obj = @scrape.fetch({})
  #     our_obj.class.to_s.should == 'Proto::Type'
  #   end

  #   it "accepts only a hash and sets default class name" do
  #     our_obj = @scrape.fetch({:name => 'default const'})
  #     our_obj.class.to_s.should == 'Proto::Type'
  #   end

  #   it "returns a Proto object with attributes set" do
  #     our_obj = @scrape.fetch('Sample', {:name => "Kevin", :title => "Developer"})
  #     our_obj.name.should == "STUBBED OUT"
  #     our_obj.title.should == "STUBBED OUT"
  #     our_obj.class.to_s.should == "Proto::Sample"
  #   end
  # end

#   context 'private methods' do
#     context ".create_return_objects" do
#       it "accepts a custom class name" do
#         our_obj = @scrape.send(:create_return_objects, 'Kevin', {})
#         our_obj.first.class.to_s.should == 'Proto::Kevin'
#       end

#       it "accepts a hash and name and sets custom attrs" do
#         our_obj = @scrape.send(:create_return_objects, 'Test', [{:name => 'Kevin'},{:title => "Title"}])
#         our_obj.first.name.should == 'Kevin'
#         our_obj.last.title.should == 'Title'
#         our_obj.length.should == 2
#       end
#     end

#     context ".scrape_attribute_data" do
#       it "returns a hash of stuff" do
#         rh = @scrape.send(:scrape_attribute_data, {:title => "h2 a"})
#         rh.should == [{:title => 'STUBBED OUT'}]
#       end
#     end
#   end
end
