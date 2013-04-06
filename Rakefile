require 'dotenv/tasks'

task :environment => :dotenv do
  require File.expand_path(File.join(*%w[ initializer ]), File.dirname(__FILE__))
  require './server'
end

task :dictbuild => :environment do
  (0..80).each do |i|
    tweets = Twitter.user_timeline("emmett9001", {:count => 200, :include_rts => false,  :include_entities => false, :exclude_replies => true, :page => i})
    dictionary = []
    tweets.each do |tweet|
      sanitized = tweet.text.gsub(/(?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?/ix, "")
      dictionary.push sanitized
    end
    
    File.open('config/dictionary.txt', 'a+') do |f|
      dictionary.each {|t| f.puts(tweet)}
    end
  end
end

task :tweet => :environment do
  emmett = Emmett.new
  #if Time.now.hour % 3 == 0 
    Twitter.update(emmett.generate_tweet)
  #end
end

desc "Open an irb session preloaded with emmetty goodness"
task :console do
  sh "irb -rubygems -I . -r initializer.rb"
end
