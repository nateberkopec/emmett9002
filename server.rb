require 'sinatra'
require 'twitter'
require 'yaml'
require 'haml'
require 'marky_markov'
require 'gabbler'

def generate_tweet
  case rand(16)
  when 0..1
    puts "TOURETTES"
    return tourettes_mode
  when 2..9
    puts 'blog'
    return blog_mode
  when 10..12
    puts 'haiku'
    return haiku_mode
  when 13..15
    puts 'entity'
    return entity_replacement
  when 16
    puts 'funny shit'
    return funny_shit
  end

end

def tourettes_mode
  candidate = MARK.generate_n_words rand(3)
  if (1..140) === candidate.length && candidate != candidate.upcase
    tweet = candidate.upcase
  else
    tourettes_mode
  end
end

def blog_mode
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
  if (1..140) === candidate.length
    tweet = candidate
  else
    blog_mode
  end
end

def haiku_mode
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
  if (1..140) === candidate.length
    tweet = candidate
  else
    haiku_mode
  end
end

def entity_replacement
  candidate = DARK.generate_1_sentence
  changed_count = 0

  candidate = candidate.split.inject do |sentence, word|
    if word.capitalize == word
      word = generate_entity
      changed_count += 1
    end
    sentence << " " + word
  end

  if (1..90) === candidate.length && (1..2) === changed_count
    return candidate
  else
    entity_replacement
  end
end

def generate_entity
  candidate = MARK.generate_1_word
  if candidate.upcase != candidate && !ENGLISH.include?(candidate.downcase)
    return candidate
  else
    generate_entity
  end

end

def funny_shit
  begin
    candidate = case rand(2)
    when 0
      MARK.generate_1_word + " " + gimme_shit
    when 1
      gimme_shit + " " + MARK.generate_1_word
    end
  rescue
    nil
  end
  if (1..140) === candidate.length
    tweet = candidate
  else
    funny_shit
  end
end

def gimme_shit
  FUNNY_SHIT[rand(FUNNY_SHIT.length)].strip
end