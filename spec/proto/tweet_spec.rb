require File.dirname(__FILE__) + '/../spec_helper'

describe Proto::Tweet do
  it 'accepts a username as a constructor' do
    tweet = Proto::Tweet.new(user_name: 'kcurtin')
    tweet.user_name.should == 'kcurtin'
  end
end