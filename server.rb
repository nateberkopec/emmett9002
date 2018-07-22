class Emmett

  def initialize
    @mark = MarkyMarkov::TemporaryDictionary.new(1)
    @mark.parse_file(File.open('config/dictionary.txt', 'a+'))
    @dark = MarkyMarkov::TemporaryDictionary.new
    @dark.parse_file 'config/blogposts.txt'
    @english = YAML.load(File.open('config/english.yaml'))
  end

  def generate_tweet
    case SecureRandom.random_number(3)
    when 0
      puts "TOURETTES"
      return tourettes_mode
    when 1
      puts 'haiku'
      return haiku_mode
    when 2
      puts 'entity'
      return entity_replacement
    end
  end

  def tourettes_mode
    candidate = @mark.generate_n_words rand(3)
    if (1..140) === candidate.length && candidate != candidate.upcase
      candidate.upcase
    else
      tourettes_mode
    end
  end

  def haiku_mode
    candidate = (@mark.generate_n_words rand(1) + 1) + " " + (@mark.generate_n_words rand(1) + 1)
    candidate.split(" ").shuffle.join(" ")
    if (1..140) === candidate.length
      candidate
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
end
