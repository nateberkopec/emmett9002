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
  case rand(16)
  when 0..1
    puts "TOURETTES"
    return tourettes_mode
  when 2..6
    puts 'blog'
    return blog_mode
  when 7..10
    puts 'haiku'
    return haiku_mode
  when 11..12
    puts 'dear self'
    return schizo_mode
  when 13..15
    puts 'entity'
    return entity_replacement
  end
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

def haiku_mode
  tweet = false
  until tweet
    candidate = ""
    begin
      candidate = case rand(3)
      when 0
        DARK.generate_n_words rand(2) + 2
      when 1
        MARK.generate_n_words rand(2) + 2
      when 2
        DARK.generate_1_word + " " + MARK.generate_1_word
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

def schizo_mode
  candidate = case rand(2)
  when 0
    "@emmett9001 dear me: " + haiku_mode
  when 1
    "@emmett9002 dear me: " + haiku_mode
  end
  if (1..140) === candidate.length
    return candidate
  else
    schizo_mode
  end
end

def entity_replacement
  candidate = DARK.generate_1_sentence.split
  changed_count = 0

  candidate.each do |word|
    if word.capitalize == word && candidate.index(word) != 0
      candidate[candidate.index(word)] = generate_entity
      changed_count += 1
    end
  end

  if (1..90) === candidate.join.length && (1..2) === changed_count
    return candidate.join(" ")
  else
    entity_replacement
  end
end

def generate_entity
  candidate = MARK.generate_1_word
  if candidate.capitalize == candidate
    return candidate
  else
    generate_entity
  end
end

