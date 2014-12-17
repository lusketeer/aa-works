module MyLib
  def diag_offsets # Diagonal direction offsets (Bishop)
    [
      [1, 1], [-1, -1],
      [1, -1], [-1, 1]
    ]
  end

  def orth_offsets # Orthogonal direction offsets (Rook)
    [
      [1, 0], [0, 1],
      [-1, 0], [0, 1]
    ]
  end

  def all_offsets # All direction offsets (Queen & King)
    diag_offsets + orth_offsets
  end

  def knights_moves
    [
      [1, 2], [-1, 2], [1, -2], [-1, -2],
      [-2, 1], [2, -1], [-2, -1], [2, 1]
    ]
  end

  def filter_moves(moves_arr)
    moves_arr.select do |pair|
      pair.all? {|coord| (0..7).cover? coord }
    end
  end

  PIECE_SYMBOLS = {
    :non_filled => {
      :knight => "♘",
      :queen  => "♕",
      :bishop => "♗",
      :rook   => "♖",
      :pawn   => "♙",
      :king   => "♔"
    },
    :filled => {
      :knight => "♞",
      :queen  => "♛",
      :bishop => "♝",
      :rook   => "♜",
      :pawn   => "♟",
      :king   => "♚"
    }
  }
end
