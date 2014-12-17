require_relative "piece.rb"
class SlidingPiece < Piece

  def moves
    # positions = []
    # (1..7).each do |multiplier|
    #   move_offsets = move_dirs.map do |offset|
    #     [multiplier * offset.first + @pos.first, multiplier * offset.last + @pos.last]
    #   end.select do |pair|
    #     pair.all? {|coord| (0..7).cover? coord }
    #   end
    #   positions += move_offsets
    # end
    # positions
    # add all possible moves to array for sliding piece
    move_offsets = []
    move_dirs.map do |direction|
      (1..7).each do |multiplier|
        position = direction.map {|coord| coord * multiplier}
        end_pos = [position.first + @pos.first, position.last + @pos.last]
        if @board[end_pos].nil?
          move_offsets << end_pos
        elsif @board[end_pos].color != self.color
          move_offsets << end_pos
          break
        else
          break
        end
      end
    end
    move_offsets << self.pos
    filter_moves(move_offsets)
  end
end
