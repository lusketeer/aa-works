require_relative "piece.rb"
class Pawn < Piece
  attr_accessor :num_moves, :move_dirs, :move_direction

  def initialize(color, symbol, board, pos, move_direction)
    super(color, symbol, board, pos)
    @num_moves = 0
    case move_direction
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
    duplicate.num_moves = @num_moves
    duplicate.move_dirs = @move_dirs
    duplicate
  end

  def move
  end

  def moves
    move_offsets = []
    move_dirs.each do |direction|
      if num_moves == 0 && direction.last == 0 # First move for the pawn
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
    # if num_moves == 0
    #   move_dirs.map do |direction|
    #     if direction.last == 0 # only multiplies when going straight
    #       (1..2).each do |multiplier|
    #         end_pos = [@pos.first + direction.first * multiplier, @pos.last]
    #         move_offsets << end_pos unless @board[end_pos].nil?
    #       end
    #     else # when making a killer move
    #       end_pos = [@pos.first + direction.first, @pos.last + direction.last ]
    #       move_offsets << end_pos if !@board[end_pos].nil? && @board[end_pos].color != self.color
    #     end
    #   end
    # else
    #   move_dirs.map do |direction|
    #     end_pos = [@pos.first + direction.first, @pos.last + direction.last]
    #     if direction.last == 0 # move straight
    #       move_offsets << end_pos unless @board[end_pos].nil?
    #     else # make a killer move
    #       move_offsets << end_pos if !@board[end_pos].nil? &&  @board[end_pos].color != self.color
    #     end
    #   end
    # end
    move_offsets
  end
end
