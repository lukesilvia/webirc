# -*- coding: utf-8 -*-
# original: http://june29.jp/2009/04/23/sinatra/

require 'rubygems'
require 'sinatra' # sudo gem install sinatra -v 0.9.1.1
require 'yaml'
require 'models/log'

log = Log.new(YAML.load(File.read(File.dirname(__FILE__) + '/config.yml')))

get '/' do
  @statuses = log.recent

  erb :index
end

get '/search' do
  @statuses = 
    if (@q = params[:q]) && !@q.empty?
      words = @q.gsub(/　/, ' ').strip.split(/\s+/)
      log.search(words)
    else
      log.recent
    end
  
  erb :index
end
