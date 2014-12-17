require_relative "sliding_piece.rb"
class Bishop < SlidingPiece

  def move_dirs
    diag_offsets
  end
end
