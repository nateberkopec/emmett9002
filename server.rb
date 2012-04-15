require 'sinatra'
require 'twitter'
require 'yaml'
require 'haml'
require 'gabbler'

get '/' do
	# show some generic stuff, documentation about mark, last tweet, etc
	@tweet = generate_tweet
  haml :index
end

def generate_tweet
	tweet = false
	until tweet
  	candidate = MARK.sentence
  	if candidate.length < 140 && candidate.length > 80
  		tweet = candidate
  		tweet[0].upcase!
  	end
  end
  return tweet
end
