class Emmett

  def initialize
    @mark = MarkyMarkov::TemporaryDictionary.new(1)
    @mark.parse_file(File.open('config/dictionary.txt', 'a+'))
    @dark = MarkyMarkov::TemporaryDictionary.new
    @dark.parse_file 'config/blogposts.txt'
    @english = YAML.load(File.open('config/english.yaml'))
    @funny_shit = *File.open('config/funny_words.txt')
  end

  def generate_tweet
    case SecureRandom.random_number(17)
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
    candidate = @mark.generate_n_words rand(3)
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
        candidate += @dark.generate_n_words rand(3) + 1
        candidate += " "
        candidate += @mark.generate_n_words rand(3) + 1
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
        @dark.generate_n_words rand(2) + 2
      when 1
        @mark.generate_n_words rand(2) + 2
      when 2
        @dark.generate_1_word + " " + @mark.generate_1_word
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
    candidate = @dark.generate_1_sentence
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
    candidate = @mark.generate_1_word
    if candidate.upcase != candidate && !@english.include?(candidate.downcase)
      return candidate
    else
      generate_entity
    end

  end

  def funny_shit
    begin
      candidate = case rand(2)
      when 0
        @mark.generate_1_word + " " + gimme_shit
      when 1
        gimme_shit + " " + @mark.generate_1_word
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

  private

  def gimme_shit
    @funny_shit[rand(@funny_shit.length)].strip
  end
end