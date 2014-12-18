require_relative "chess_collection.rb"
require 'byebug'
require_relative "error_collection.rb"
require "colorize"
class Board
  include MyLib
  attr_accessor :board, :cursor, :selected_piece, :game_over
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    @cursor = [0, 0]
    @selected_piece = nil
    @game_over = false
  end

  def dup
    dup_board = Board.new
    board.flatten.compact.each do |piece|
      if piece.is_a?(Pawn)
        dup_board[piece.pos] = piece.class.new(piece.color, piece.symbol, dup_board, piece.pos.dup, piece.move_direction)
      else
        dup_board[piece.pos] = piece.class.new(piece.color, piece.symbol, dup_board, piece.pos.dup)
      end
    end
    dup_board
  end

  def build_board
    # populate @boad with black & white pieces for chess game
    (0..7).each do |col|
      # populate pawns
      self[[1, col]] = Pawn.new(:filled, PIECE_SYMBOLS[:filled][:pawn], self, [1, col], :down)
      self[[6, col]] = Pawn.new(:non_filled, PIECE_SYMBOLS[:non_filled][:pawn], self, [6, col], :up)

      # populate rooks
      if [0, 7].include?(col)
        self[[0, col]] = Rook.new(:filled, PIECE_SYMBOLS[:filled][:rook], self, [0, col])
        self[[7, col]] = Rook.new(:non_filled, PIECE_SYMBOLS[:non_filled][:rook], self, [7, col])
      end
      # populate knights
      if [1, 6].include?(col)
        self[[0, col]] = Knight.new(:filled, PIECE_SYMBOLS[:filled][:knight], self, [0, col])
        self[[7, col]] = Knight.new(:non_filled, PIECE_SYMBOLS[:non_filled][:knight], self, [7, col])
      end

      # populate bishops
      if [2, 5].include?(col)
        self[[0, col]] = Bishop.new(:filled, PIECE_SYMBOLS[:filled][:bishop], self, [0, col])
        self[[7, col]] = Bishop.new(:non_filled, PIECE_SYMBOLS[:non_filled][:bishop], self, [7, col])
      end

      # populate queens
      if col == 3
        self[[0, col]] = Queen.new(:filled, PIECE_SYMBOLS[:filled][:queen], self, [0, col])
        self[[7, col]] = Queen.new(:non_filled, PIECE_SYMBOLS[:non_filled][:queen], self, [7, col])
      end

      # populate kings
      if col == 4
        self[[0, col]] = King.new(:filled, PIECE_SYMBOLS[:filled][:king], self, [0, col])
        self[[7, col]] = King.new(:non_filled, PIECE_SYMBOLS[:non_filled][:king], self, [7, col])
      end
    end
    nil

  end

  def [](pos)
    r, c = pos
    @board[r][c]
  end

  def []=(pos, val)
    r, c = pos
    val.pos = pos unless val.nil?
    @board[r][c] = val
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    self[start_pos] = nil
    piece.pos = end_pos
    self[end_pos] = piece
  end

  def entire_color(color)
    @board.flatten.compact.select { |piece| piece.color == color }
  end

  def find_king(color)
    entire_color(color).find {|k| k.is_a?(King) }
  end

  def in_check?(color)
    other_color = ([:non_filled, :filled] - [color]).first
    other_color_moves = []
    # entire_color(other_color)
    entire_color(other_color).each do |other_color_piece|
      other_color_moves += other_color_piece.moves
    end
    if find_king(color).nil?
      game_over = true
      return true
    end
    current_king_position = find_king(color).pos
    other_color_moves.include?(current_king_position)
  end

  def checkmate?(color)
    # return T or F if valid moves array is empty for all of color's pieces
    uncheck = []
    entire_color(color).each do |piece|
      piece.moves.each do |move|
        uncheck << move unless piece.move_into_check?(move)
      end
    end

    uncheck.empty?
  end

  def print_board
    print "  "
    ('a'..'h').each {|c| print "#{c} "}
    puts
    (0..7).each do |row|
      print "#{8 - row} "
      (0..7).each do |col|
        current_piece = self[[row, col]]
        unless current_piece.nil?
          color = current_piece.color
          symbol = current_piece.symbol
        end
        if @cursor == [row, col]
          if @selected_piece.nil?
            print "#{(current_piece.nil?) ? ' '.on_white : symbol.black.on_white} "
          else
            print "#{@selected_piece.symbol.black.on_white} "
          end
        else
          print "#{(current_piece.nil?) ? ' ' : symbol} "
        end
      end
      print "#{8 - row}\n"
    end
    print "  "
    ('a'..'h').each {|c| print "#{c} "}
    puts ""
  end

  # def play
  #   build_board
  #   loop do
  #     system("clear")
  #     # puts "Cursor: #{@cursor} | Selected: #{@selected_piece.moves unless @selected_piece.nil?}"
  #     print_board
  #     begin
  #       system("stty raw -echo")
  #       option = STDIN.getc
  #       # rescue InvalidMoveError => e
  #       #   puts "Error: #{e.message}"
  #       #   retry
  #     ensure
  #       system("stty -raw echo")
  #     end
  #     @cursor = @cursor.dup
  #     case option
  #     when "w"
  #       @cursor[0] -= 1 if @cursor[0] > 0
  #     when "s"
  #       @cursor[0] += 1 if @cursor[0] < 7
  #     when "a"
  #       @cursor[1] -= 1 if @cursor[1] > 0
  #     when "d"
  #       @cursor[1] += 1 if @cursor[1] < 7
  #     when "\e"
  #       break
  #     when "j"
  #       pick_up
  #     when "k"
  #       put_down
  #     end
  #   end
  # end
  #
  # def pick_up
  #   if !self[@cursor].nil? && @selected_piece.nil?
  #     @selected_piece = self[@cursor]
  #     self[@cursor] = nil
  #   end
  # end
  #
  # def put_down
  #   if !@selected_piece.nil? && @selected_piece.moves.include?(@cursor) # valid move
  #     unless @cursor == @selected_piece.moves.last # check to see if piece is put in the pick up position
  #       @selected_piece.first_move = false if @selected_piece.is_a?(Pawn)
  #     end
  #     @selected_piece.pos = @cursor
  #     self[@cursor] = @selected_piece
  #     @selected_piece = nil
  #   end
  # end
end

# b = Board.new
# b.play
# b.build_board
# r = Rook.new(:filled, "R", b, [7, 0])
# r2 = Rook.new(:filled, "R", b, [6, 0])
# k = King.new(:non_filled, "K", b, [7, 7])
# b[r.pos] = r
# b[r2.pos] = r2
# b[k.pos] = k
# b.print_board
# p q.moves
# p b.in_check?(:non_filled)
# p r.moves
# p k.valid_moves
# p b.checkmate?(:non_filled)
# b.build_board
#
# pawn = b[[1, 1]]
# p pawn.moves
