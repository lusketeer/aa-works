require_relative "poly_tree_node.rb"

class WordChainer
  attr_accessor :dictionary, :filtered
  def initialize(dictionary_file_name)
    require 'set'
    @dictionary = Set.new.merge(File.readlines("dictionary.txt").map(&:chomp))
    @filtered = @dictionary
  end

  def set_word_size(size)
    @filtered = filtered.select { |el| el.length == size }
  end

  def adjacent_words(word)
    reg_collection = []
    word.size.times do |i|
      temp = word.dup
      temp[i] = "."
      reg_collection << temp
    end
    filtered.select do |dict_word|
      reg_collection.any? { |reg| dict_word =~ /^#{reg}$/i && dict_word != word  }
    end
  end


  def build_chains(source)
    root = PolyTreeNode.new(source)
    q = [root]
    all_seen_words = [source]
    filtered_dictionary = filtered
    until q.empty?
      node = q.shift
      adjacent_words(node.value).each do |adjacent_word|
        unless all_seen_words.include?(adjacent_word)
          all_seen_words << adjacent_word
          child_node = PolyTreeNode.new(adjacent_word)
          child_node.parent = node
          q << child_node
        end
      end
    end

    root
  end

  def run(source, target)
    set_word_size(target.size)
    root = build_chains(source)
    target_node = root.bfs(target)
    target_node.trace_path_back
  end

end

wc = WordChainer.new("dictionary.txt")
# p wc.run("duck", "ruby")
wc.set_word_size(4)
p wc.build_chains("duck")
# p "duck"
# temp_duck = wc.adjacent_words("duck")
# p temp_duck
# p temp_duck.first
# temp_duck = wc.adjacent_words(temp_duck.first)
# p temp_duck
# p temp_duck.first
# temp_duck = wc.adjacent_words(temp_duck.first)
# p temp_duck
# p temp_duck.first
# temp_duck = wc.adjacent_words(temp_duck.first)
# p temp_duck
# p temp_duck.first
