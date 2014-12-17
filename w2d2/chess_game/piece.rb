require_relative "my_lib.rb"
class Piece
  attr_reader :color, :symbol
  attr_accessor :pos
  include MyLib
  
  def initialize(color, symbol, board, pos)
    @color, @symbol, @board, @pos = color, symbol, board, pos
  end
end
