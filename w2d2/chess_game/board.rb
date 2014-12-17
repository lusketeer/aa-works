require_relative "chess_collection.rb"
require_relative "error_collection.rb"
require "colorize"
class Board
  include MyLib
  attr_accessor :board, :cursor, :selected_piece
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    @cursor = [0, 0]
    @selected_piece = nil
  end

  def dup
    dup_board = Board.new
    (0..7).each do |row_index|
      (0..7).each do |col_index|
        position = [row_index, col_index]
        unless self[position].nil?
          piece = self[position].dup
          piece.board = dup_board
        else
          piece = nil
        end
        dup_board[position] = piece
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

  def in_check?(color)
  end

  def play
    build_board
    loop do
      system("clear")
      puts "Cursor: #{@cursor} | Selected: #{@selected_piece.moves unless @selected_piece.nil?}"
      print_board
      begin
        system("stty raw -echo")
        option = STDIN.getc
      # rescue InvalidMoveError => e
      #   puts "Error: #{e.message}"
      #   retry
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
    @selected_piece = self[@cursor].dup
    self[@cursor] = nil
  end

  def put_down
    if @selected_piece.moves.include?(@cursor) # valid move
      @selected_piece.pos = @cursor.dup
      self[@cursor] = @selected_piece
      @selected_piece = nil
    # else
    #   raise InvalidMoveError.new "Invalid move"
    end
  end
end

b = Board.new
b.play
# b.build_board
#
# pawn = b[[1, 1]]
# p pawn.moves
