require_relative "piece.rb"
class SteppingPiece < Piece

  def moves
    move_offsets = []
    move_dirs.map do |direction|
      end_pos = [direction.first + @pos.first, direction.last + @pos.last]
      if @board[end_pos].nil?
        move_offsets << end_pos
      elsif @board[end_pos].color != self.color
        move_offsets << end_pos
      end
    end

    filter_moves(move_offsets)
  end
end
