require_relative "sliding_piece.rb"
class Rook < SlidingPiece
  def move_dirs
    orth_offsets
  end
end
