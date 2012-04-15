require 'sinatra'
require 'twitter'
require 'yaml'
require 'haml'
require 'marky_markov'
require 'gabbler'

get '/' do
	# show some generic stuff, documentation about mark, last tweet, etc
	@tweet = generate_tweet
  haml :index
end

def generate_tweet
	tweet = false
	until tweet
    begin
      candidate = MARK.generate_n_words rand(15)
    rescue
      next
    end
  	if candidate.length < 140 && candidate.length > 1
  		tweet = candidate
  	end
  end
  return tweet
end
