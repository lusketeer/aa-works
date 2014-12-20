require_relative "deck"
require_relative "hand"

10000.times do
  deck = Deck.new
  hand_1 = Hand.new(deck.take(5))
  hand_2 = Hand.new(deck.take(5))
  puts "Player 1: " + hand_1.to_s
  puts "Player 2: " + hand_2.to_s
  puts hand_1.beat?(hand_2) == 1 ? "Player 1 wins" : "Player 2 wins"
  puts
end
