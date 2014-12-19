require_relative "board.rb"
require_relative "players/human_player.rb"
require "byebug"
class Game
  attr_reader :board, :players
  attr_accessor :cur_player
  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new(10)
    @cur_player = players.first
  end

  def play
    until game_over?
      break unless cur_player.play_move(board)
      @cur_player = (players - [cur_player]).first
    end
    if game_over?
      puts "Game over"
      puts "#{self.winner.name.capitalize} wins"
    end
  end

  def game_over?
    players.map { |player| player.color }.any? { |color| out_of_moves?(color) }
  end

  def out_of_moves?(color)
    available_moves = []
    unless board.pieces(color).empty?
      board.pieces(color).each do |piece|
        available_moves += piece.valid_moves
      end
    end
    available_moves.empty?
  end

  def winner
    out_of_moves?(cur_player.color) ? (players - [cur_player]).first : cur_player
  end
end

p1 = HumanPlayer.new("Luke", :white)
p2 = HumanPlayer.new("Leia", :black)
g = Game.new(p1, p2)
g.play
