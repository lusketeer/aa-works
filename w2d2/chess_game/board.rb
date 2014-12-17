require_relative "chess_collection.rb"
require "colorize"
class Board
  include MyLib
  attr_accessor :board, :cursor, :selected_piece
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    @cursor = [0, 0]
    @selected_piece = nil
  end

  def play
    build_board
  end

  def dup
    dup_board = Board.new
    dup_board.board = self.board.map do |row|
      row.map do |col|
        col.board = dup_board unless col.nil?
        col
      end
    end
    dup_board
  end

  def build_board
    # populate @boad with black & white pieces for chess game
    (0..7).each do |col|
      # populate pawns
      self[[1, col]] = Pawn.new(:filled, PIECE_SYMBOLS[:filled][:pawn], self, [1, col], :down)
      self[[6, col]] = Pawn.new(:non_filled, PIECE_SYMBOLS[:non_filled][:pawn], self, [7, col], :up)

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
    @board[r][c] = val
  end

  def move(start_pos, end_pos)

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
          print "#{(current_piece.nil?) ? ' '.on_white : symbol.on_white} "
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

  def in_check?(color)
  end

  def play
    loop do
      system("clear")
      print_board
      begin
        system("stty raw -echo")
        option = STDIN.getc
      ensure
        system("stty -raw echo")
      end
      case option
      when "w"
        @cursor[0] -= 1 if @cursor[0] > 0
      when "s"
        @cursor[0] += 1 if @cursor[0] < 7
      when "a"
        @cursor[1] -= 1 if @cursor[1] > 0
      when "d"
        @cursor[1] += 1 if @cursor[1] < 7
      when "\e"
        break
      when "j"
        pick_up
      when "k"
        put_down
      end
    end
    # if won?
    #   puts "You won!"
    # else
    #   puts "You died! Game over!"
    # end
  end
  def pick_up
  end

  def put_down
  end
end

b = Board.new
b.play
b.print_board
king = b[[0,4]]
knight = b[[0,1]]
include MyLib
b[[2,2]] = Pawn.new(:non_filled, PIECE_SYMBOLS[:non_filled][:pawn], b, [2,2], :up)
b.print_board
pawn = b[[1,1]]
p pawn.moves
