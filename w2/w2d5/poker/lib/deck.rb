require_relative 'card'

class Deck

  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUIT_STRINGS.each_key do |suit|
      Card::VALUE_STRINGS.each_key do |value|
        @cards << Card.new(suit, value)
      end
    end
    @cards.shuffle!
  end

  def take(n = 1)
    @cards.pop(n)
  end

end
