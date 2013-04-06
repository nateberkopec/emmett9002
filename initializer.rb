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

ENVIRONMENT = ENV['RACK_ENV']
APP_CONFIG = YAML.load(File.read("config/config.yml"))[ENVIRONMENT]

Twitter.configure do |config|
  config.consumer_key = APP_CONFIG[:twitter][:consumer_key]
  config.consumer_secret = APP_CONFIG[:twitter][:consumer_secret]
  config.oauth_token = APP_CONFIG[:twitter][:oauth_token]
  config.oauth_token_secret = APP_CONFIG[:twitter][:oauth_token_secret]
end
