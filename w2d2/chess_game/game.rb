require_relative "board.rb"
require_relative "human_player.rb"
require 'byebug'
class Game
  attr_accessor :whose_turn
  attr_reader :board

  def initialize(player1, player2, board = Board.new)
    @player1, @player2 = player1, player2
    @board = board
    @board.build_board
    @whose_turn = player1
  end

  def play
    # board.entire_color(:non_filled).each do |piece|
    #   piece.moves.each do |move|
    #     p piece
    #     p move
    #   end
    # end
    until self.board.checkmate?(:non_filled) || self.board.checkmate?(:filled)
      break unless @whose_turn.play_turn(self) #returns false if user wants to quit
      @whose_turn = ([@player2, @player1] - [@whose_turn]).first
    end
    puts "Game over."
  end
end


g = Game.new(HumanPlayer.new(:filled), HumanPlayer.new(:non_filled))
g.board.print_board
g.play
