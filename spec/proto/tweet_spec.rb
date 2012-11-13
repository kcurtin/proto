require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Tweet do
  it 'accepts a username as a constructor' do
    tweet = Proto::Tweet.fetch_tweets('kcurtin')
    tweet.user_name.should == 'kcurtin'
  end

  it "returns a tweet object" do
    tweet = Proto::Tweet.fetch_tweets('kcurtin')
    tweet.first.class.to_s.should == 'Proto::Tweet'
    # puts Proto::Tweet.all
  end
end