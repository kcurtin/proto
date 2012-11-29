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
    jobs = obj.fetch({  title:       'h2.jam_headline',
                        company:     'h3 a.jam_link',
                        location:    'div#c_address',
                        type:        'div#c_jobtype',
                        description: 'div#c_job_description' }
                      )
    jobs.first.should == 'test'
  end
end

# ruby_inside = Scraper.new('Ruby Inside', 'http://ruby.jobamatic.com/a/jbb/find-jobs/', 
#                           'http://ruby.jobamatic.com', job_database)
# ruby_inside.compile_job_url_collection('tr.listing td.title a')
# ruby_inside.scrape_away({
#   title_text:       'h2.jam_headline',
#   # company_text:     'h3 a.jam_link',
#   location_text:    'div#c_address',
#   type_text:         'div#c_jobtype',
#   description_text: 'div#c_job_description'
# })