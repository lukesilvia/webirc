require File.dirname(__FILE__) + '/../spec_helper'
require 'webirc'

describe 'IRCWeb' do
  include Sinatra::Test
  
  it 'should show recent statuses' do
    get '/'
    
    response.should be_ok
  end

  it 'should search statuses with query' do
    get '/search', :q => 'hoge'
    
    response.should be_ok
  end
end
