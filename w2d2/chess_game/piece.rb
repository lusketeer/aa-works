require_relative "my_lib.rb"
class Piece
  attr_reader :color, :symbol
  attr_accessor :pos, :board
  include MyLib

  def initialize(color, symbol, board, pos)
    @color, @symbol, @board, @pos = color, symbol, board, pos
  end

  def inspect
    {
      color:  color,
      symbol: symbol,
      pos:    pos
    }
  end

  def other_player
    ([:non_filled, :filled] - [self.color]).first
  end

  def valid_moves
    self.moves.select do |move|
      # check to see if player is in check
      !self.move_into_check?(move)
    end
  end

  def move_into_check?(move)
    dupped_board = @board.dup
    dupped_board.move(@pos, move)
    dupped_board.in_check?(self.color)
  end
end
