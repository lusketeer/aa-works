require_relative "piece.rb"
class SlidingPiece < Piece
  def moves
    move_offsets = []
    move_dirs.map do |direction|
      (1..7).each do |multiplier|
        position = direction.map {|coord| coord * multiplier}
        end_pos = [position.first + @pos.first, position.last + @pos.last]
        if valid_coord?(end_pos)
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
    end
    move_offsets << self.pos
  end
end
