require 'dotenv/tasks'

task :environment => :dotenv do
  require File.expand_path(File.join(*%w[ initializer ]), File.dirname(__FILE__))
  require './server'
end

task :dictbuild => :environment do
  (0..80).each do |i|
    sleep(60)
    tweets = CLIENT.user_timeline("sensitiveemmett", {
      :count => 200, :include_rts => false,  :include_entities => false,
      :exclude_replies => true, :page => i
    })

    tweets.map! do |tweet|
      tweet.text.gsub(/(?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?/ix, "")
    end

    File.open('config/dictionary.txt', 'a+') do |f|
      tweets.each {|t| f.puts(t)}
    end
  end
end

task :tweet => :environment do
  emmett = Emmett.new
  if Time.now.hour % 3 == 0
    CLIENT.update(emmett.generate_tweet)
  end
end

desc "Open an irb session preloaded with emmetty goodness"
task :console do
  sh "irb -rubygems -I . -r initializer.rb"
end
