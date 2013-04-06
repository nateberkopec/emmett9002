require "rubygems"
require "bundler/setup"

require 'dotenv'
Dotenv.load

require 'sinatra'
require 'marky_markov'
require 'haml'
require 'twitter'
require 'nokogiri'
require 'gabbler'
require 'yaml'
require 'securerandom'

Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
end
