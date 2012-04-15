require 'sinatra'
require 'twitter'
require 'yaml'
require 'haml'
require 'marky_markov'
require 'gabbler'

get '/' do
	# show some generic stuff, documentation about mark, last tweet, etc
	@tweet = generate_tweet(rand(7))
  haml :index
end

def generate_tweet(mode)
	case mode
  when 0..2
    return sentence_mode
  when 3..5
    return word_mode
  when 6
    return tourettes_mode
  end
end

def sentence_mode
  tweet = false
  until tweet
    begin
      candidate = MARK.generate_1_sentence
    rescue
      next
    end
    if candidate.length < 140 && candidate.length > 20
      tweet = candidate
    end
  end
  return tweet
end

def word_mode
  tweet = false
  until tweet
    begin
      candidate = MARK.generate_n_words rand(5) - 2
    rescue
      next
    end
    if candidate.length < 140 && candidate.length > 1
      tweet = candidate
    end
  end
  return tweet
end

def tourettes_mode
  tweet = false
  until tweet
    begin
      candidate = MARK.generate_n_words rand(3)
    rescue
      next
    end
    if candidate.length < 140 && candidate.length > 1 && candidate != candidate.upcase
      tweet = candidate.upcase
    end
  end
  return tweet
end


