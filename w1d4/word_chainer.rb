class WordChainer
  attr_accessor :dictionary, :filtered
  def initialize(dictionary_file_name)
    require 'set'
    @dictionary = Set.new.merge(File.readlines("dictionary.txt").map(&:chomp))
    @filtered = false
  end

  def set_word_size(size)
    self.dictionary = self.dictionary.select { |el| el.length == size }
    filtered = true
  end

  def adjacent_words(word)
    set_word_size(word.size) unless filtered
    reg_collection = []
    word.size.times do |i|
      temp = word.dup
      temp[i] = "."
      reg_collection << temp
    end
    dictionary.select do |dict_word|
      reg_collection.any? { |reg| dict_word =~ /^#{reg}$/i && dict_word != word  }
    end
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = [source]
    until @current_words.empty?
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent_word|
          unless @all_seen_words.include?(adjacent_word)
            new_current_words << adjacent_word
            @all_seen_words << adjacent_word
          end
        end
      end
      p new_current_words
      @current_words = new_current_words
    end
  end

end
