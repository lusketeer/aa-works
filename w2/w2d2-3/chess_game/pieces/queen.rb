require_relative "sliding_piece.rb"
class Queen < SlidingPiece
  def move_dirs
    all_offsets
  end
end
