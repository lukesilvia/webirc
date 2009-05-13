# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
require 'string_utility'

describe StringUtility do
  describe '::to_words' do
    it 'should split text by spaces' do
      words = StringUtility.to_words('hoge fuga')
      
      words.should have(2).items
      words.should == %w[hoge fuga]
      
      words = StringUtility.to_words('hoge fuga   wibble')
      
      words.should have(3).items
      words.should == %w[hoge fuga wibble]
    end
    
    it 'should handle full space as delimiter' do  
      words = StringUtility.to_words('hoge　fuga　 　wibble')
      
      words.should have(3).items
      words.should == %w[hoge fuga wibble]
    end
  end
end
