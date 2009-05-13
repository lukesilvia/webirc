# -*- coding: utf-8 -*-
# original: http://june29.jp/2009/04/23/sinatra/

require 'rubygems'
require 'sinatra' # sudo gem install sinatra -v 0.9.1.1
require 'yaml'
require 'models/log'
require 'models/string_utility'

log = Log.new(YAML.load(File.read(File.dirname(__FILE__) + '/config.yml')))

get '/' do
  @statuses = log.recent

  erb :index
end

get '/search' do
  @statuses = 
    if (q = params[:q]) && !q.empty?
      @words = StringUtility.to_words(q)
      log.search(@words)
    else
      log.recent
    end
  
  erb :index
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  
  # from Rails
  def highlight(text, words)
    if [text, words].any?{|e| e.nil? || e.empty? }
      text
    else
      match = Regexp.union(words)
      text.gsub(/(#{match})/){ %Q{<strong class="highlight">#{$1}</strong>} }
    end
  end
end
