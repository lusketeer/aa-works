require_relative "stepping_piece.rb"
class King < SteppingPiece
  
  def move_dirs
    all_offsets
  end
end
