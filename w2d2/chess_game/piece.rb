require_relative "my_lib.rb"
class Piece
  attr_reader :color, :symbol, :board
  attr_accessor :pos
  include MyLib

  def initialize(color, symbol, board, pos)
    @color, @symbol, @board, @pos = color, symbol, board, pos
  end


  def dup
    self.class.new(@color, @symbol, @board, @pos)
  end

  def inspect
    {
      color:  color,
      symbol: symbol,
      pos:    pos
    }
  end
end
