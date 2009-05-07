# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
require 'log'

describe Log do
  before(:all) do
    @log = Log.new({
      'log_dir' => File.dirname(__FILE__) + '/../fixtures/test_log',
      'status_regexp' => '^(\d\d:\d\d) (\w+): (.+)$'
    })
  end
  
  describe '#recent' do
    it 'should return recent statuses with limit' do
      result = @log.recent(0)
      
      result.should be_empty
      
      result = @log.recent(5)
      
      result.should have(5).items
      result.first[:time].should == '2009-04-17 03:01'
      result.first[:nick].should == 'bob'
      result.first[:message].should == 'bob4回目'
    end
  end
  
  describe '#search' do
    it 'should return matched statuses on nick' do
      result = @log.search('bob')
      
      result.should have(4).items
    end
    
    it 'should return matched statuses on message' do
      result = @log.search('4回目')
      
      result.should have(1).items
    end

    it 'should be able to and search by multiple words' do
      result = @log.search(%w[bob 3回目])
      
      result.should have(1).items
    end
  end
end
