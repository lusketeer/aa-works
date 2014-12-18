require_relative "piece.rb"
class Pawn < Piece
  attr_accessor :first_move, :move_direction
  attr_reader :move_dirs

  def initialize(color, symbol, board, pos, move_direction)
    super(color, symbol, board, pos)
    @first_move = true
    @move_direction = move_direction
    case @move_direction
    when :down
      @move_dirs =  [
        [1, -1],
        [1, 0],
        [1, 1]
      ]
    when :up
      @move_dirs = [
        [-1, -1],
        [-1, 0],
        [-1, 1]
      ]
    end
  end

  def dup
    duplicate = Pawn.new(@color, @symbol, @board, @pos, @move_direction)
    duplicate.first_move = @first_move
    duplicate.move_dirs = @move_dirs.dup
    duplicate
  end

  def moves
    move_offsets = []
    move_dirs.each do |direction|
      if first_move && direction.last == 0 # First move for the pawn
        (1..2).each do |multi|
          end_pos = [self.pos.first + direction.first * multi, self.pos.last]
          if self.board[end_pos].nil? # add when it's empty
            move_offsets << end_pos
          else # break out of the loop when it's not empty
            break
          end
        end
      else # Not the first move for the pawn
        end_pos = [self.pos.first + direction.first, self.pos.last + direction.last]
        if direction.last == 0 # straight move
          move_offsets << end_pos if self.board[end_pos].nil?
        else # diagonal move
          move_offsets << end_pos if !self.board[end_pos].nil? && self.board[end_pos].color != self.color
        end
      end
    end
    move_offsets << self.pos
    move_offsets
  end
end
