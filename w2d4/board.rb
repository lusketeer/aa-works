require "byebug"
require "colorize"
require_relative "piece.rb"
class Board
  attr_reader :size
  attr_accessor :grid, :cursor, :selected_piece
  def initialize(size, fill_board = true)
    @size = size
    @grid = Array.new(size) {Array.new(size) }
    fill_starting_grid if fill_board
    @cursor = [0, 0]
    @selected_piece = nil
  end

  def dup
    dup_board = Board.new(10, false)
    grid.flatten.compact.each do |piece|
      Piece.new(piece.color, dup_board, piece.pos.dup, piece.king)
    end
    dup_board
  end

  def [](pos)
    r, c = pos
    @grid[r][c]
  end

  def []=(pos, piece)
    r, c = pos
    @grid[r][c] = piece
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def empty?(pos)
    self[pos].nil?
  end

  def pieces(color)
    grid.flatten.compact.select { |piece| piece.color == color }
  end

  def valid_pos?(pos)
    pos.all? { |coord| (0...size).cover? coord }
  end

  def render
    (0...size).each do |row|
      (0...size).each do |col|
        bg_color = (row + col).odd? ? :on_light_black : :on_light_white
        piece = self[[row, col]]
        if cursor == [row, col]
          square = piece.nil? ? "   " : " #{piece.render} "
          square = @selected_piece.nil? ? square : " #{@selected_piece.render} "
          print square.black.on_light_blue
        elsif !@selected_piece.nil? && @selected_piece.pos == [row, col]
          print " #{piece.render} ".magenta.on_light_green
        else
          square = piece.nil? ? "   " : " #{piece.render} "
          print square.send(bg_color)
        end
      end
      puts
    end
  end

  def fill_rows(color)
    # white at bottom, black at top
    rows = (color == :white) ? ((size - 4)...size).to_a : (0..3).to_a
    rows.each do |row|
      (0...size).each do |col|
        Piece.new(color, self, [row, col]) if (row + col).odd?
      end
    end
  end

  def fill_starting_grid
    [:white, :black].each do |color|
      fill_rows(color)
    end
  end
end

# b = Board.new(10)
# b.render
# b.cursor = [6, 1]
# b.selected_piece = b[b.cursor]
# puts
# b.render
# b.cursor = [5, 2]
# b.selected_piece.perform_moves([b.cursor])
# b.selected_piece = nil
# puts
# b.render



b = Board.new(10, false)
# white_king = Piece.new(:white, b, [0, 1])
# black = Piece.new(:black, b, [2, 3])
# black2 = Piece.new(:black, b, [2, 5])
# black2 = Piece.new(:black, b, [2, 7])
white = Piece.new(:white, b, [7, 2])
black = Piece.new(:black, b, [6, 3])
black2 = Piece.new(:black, b, [5, 2])
black2 = Piece.new(:black, b, [4, 3])
# white_king.promote
b.render
# # debugger
# white_king.perform_moves([[1, 2]])
puts
b.render
# seq = [[3, 4], [1, 6], [3, 8]]
seq = [[5, 4], [3, 2]]
p white.valid_move_seq?(seq)
white.perform_moves(seq)
# p white_king.valid_move_seq?(seq)
# white_king.perform_moves(seq)
puts
b.render
# p b.pieces(:black).empty?
