require 'sinatra'
require 'twitter'
require 'yaml'
require 'haml'
require 'marky_markov'
require 'gabbler'

get '/' do
	# show some generic stuff, documentation about mark, last tweet, etc
	@tweet = generate_tweet(rand(11))
  haml :index
end

def generate_tweet(mode)
	case mode
  when 0
    return sentence_mode
  when 1..5
    return word_mode
  when 6
    return tourettes_mode
  when 7..10
    return blog_mode
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
      candidate = MARK.generate_n_words rand(15) - 2
    rescue
      next
    end
    if candidate.length < 140 && candidate.length > 10
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

def blog_mode
  tweet = false
  until tweet
    candidate = ""
    begin
      rand(4).times do
        candidate += DARK.generate_n_words rand(3) + 1
        candidate += " "
        candidate += MARK.generate_n_words rand(3) + 1
        candidate += " "
      end
    rescue
      nil
    end
    if candidate.length < 140 && candidate.length > 1
      tweet = candidate
    end
  end
  return tweet
end


