require_relative "board.rb"
require_relative "human_player.rb"
require "byebug"
class Game
  attr_reader :board, :players
  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new(10)
  end

  def play
    cur_player = players.first
    until won?
      break unless cur_player.play_move(board)
      cur_player = (players - [cur_player]).first
    end
    puts "Game over"
    winner = (players - [cur_player]).first if board.pieces(cur_player.color).empty?
    puts "#{winner.color.to_s.capitalize} wins"
  end

  def won?
    players.map {|player| player.color }.any? { |color| board.pieces(color).empty? }
  end
end

p1 = HumanPlayer.new("Luke", :white)
p2 = HumanPlayer.new("Leia", :black)
g = Game.new(p1, p2)
g.play
