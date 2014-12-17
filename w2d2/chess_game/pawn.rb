require_relative "piece.rb"
class Pawn < Piece
  attr_accessor :num_moves, :move_dirs

  def initialize(color, symbol, board, pos, move_direction)
    super(color, symbol, board, pos)
    @num_moves = 0
    case move_direction
    when :down
      @move_dirs =  [
        [-1, 1],
        [0, 1],
        [1, 1]
      ]
    when :up
      @move_dirs = [
        [-1, -1],
        [0, -1],
        [1, -1]
      ]
    end
  end

  def move
  end

  def moves
    move_offsets = []
    if num_moves == 0
      move_dirs.map do |direction|
        if direction.first == 0 # only multiplies when going straight
          (1..2).each do |multiplier|
            end_pos = [@pos.first, @pos.last + direction.last * multiplier]
            move_offsets << end_pos unless @board[end_pos].nil?
          end
        else # when making a killer move
          end_pos = [@pos.first + direction.first, @pos.last + direction.last ]
          move_offsets << end_pos if !@board[end_pos].nil? && @board[end_pos].color != self.color
        end
      end
    else
      move_dirs.map do |direction|
        end_pos = [@pos.first + direction.first, @pos.last + direction.last]
        if direction.first == 0 # move straight
          move_offsets << end_pos unless @board[end_pos].nil?
        else # make a killer move
          move_offsets << end_pos if !@board[end_pos].nil? &&  @board[end_pos].color != self.color
        end
      end
    end
    move_offsets
  end
end
