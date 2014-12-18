require_relative "piece.rb"
class SteppingPiece < Piece

  def moves
    move_offsets = []
    move_dirs.map do |direction|
      end_pos = [direction.first + @pos.first, direction.last + @pos.last]
      if valid_coord?(end_pos)
        if @board[end_pos].nil?
          move_offsets << end_pos
        elsif @board[end_pos].color != self.color
          move_offsets << end_pos
        end
      end
    end
    move_offsets << self.pos
  end
end
