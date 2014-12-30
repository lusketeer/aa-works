require_relative "direction.rb"

require 'byebug'

class InvalidMoveError < StandardError; end
class Piece
  include Direction
  attr_reader :color, :king, :board
  attr_accessor :pos
  def initialize(color, board, pos, king = false)
    @color, @board, @pos, @king = color, board, pos, king
    board.add_piece(self, pos)
  end

  def symbols
    if king
      { white: '♔', black: '♚' }
    else
      { white: "○",  black: "●" }
    end
  end

  def inspect
    {
      color: color,
      king: king,
      pos: pos
    }
  end

  def dup
    Piece.new(color, board, pos.dup, king)
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
      self.promote if self.maybe_promote?
    else
      raise InvalidMoveError.new "Invalid Moves"
    end
  end

  def perform_moves!(move_sequence)
    return false if move_sequence.empty?
    if (move_sequence.size == 1)
      move = move_sequence.first
      success =  perform_slide(move) || perform_jump(move)
    else
      success = move_sequence.all? { |move| perform_jump(move) }
    end
    raise InvalidMoveError.new "Invalid Moves" unless success
  end

  def valid_move_seq?(move_sequence)
    test_board = self.board.dup
    cur_pos = self.pos.dup
    test_piece = test_board[cur_pos]
    begin
      test_piece.perform_moves!(move_sequence)
      true
    rescue InvalidMoveError => e
      puts e.message
      false
    end
  end

  def perform_slide(to_pos)
    if !valid_slides.empty? && valid_slides.include?(to_pos)
      board[pos] = nil
      self.pos = to_pos
      board[to_pos] = self
      return true
    end
    false
  end

  def perform_jump(to_pos)
    if !valid_jumps.empty? && valid_jumps.include?(to_pos)
      enemy_pos = middle_pos(pos, to_pos)
      board[pos] = nil
      board[enemy_pos] = nil
      self.pos = to_pos
      board[to_pos] = self
      return true
    end
    false
  end

  def valid_slides
    result = []
    move_dirs.each do |dir|
      to_pos = [dir.first + pos.first, dir.last + pos.last]
      result << to_pos if board.empty?(to_pos) && board.valid_pos?(to_pos)
    end
    result << pos
  end

  def valid_jumps
    result = []
    move_dirs.each do |dir|
      to_pos = [dir.first + pos.first, dir.last + pos.last]
      if !board.empty?(to_pos) && (board[to_pos].color != color)
        enemy_piece = board[to_pos]
        jump_pos = [dir.first + to_pos.first, dir.last + to_pos.last]
        result << jump_pos if board.valid_pos?(jump_pos) && board.empty?(jump_pos)
      end
    end
    result << pos
  end

  def valid_moves
    valid_slides + valid_jumps
  end

  def move_dirs
    if king
      up + down
    else
      (color == :white) ? up : down
    end
  end

  def render
    symbols[color]
  end

  def promote
    @king = true
  end

  def maybe_promote?
    cur_row = pos.first
    if color == :white
      cur_row == 0
    else
      cur_row == board.size
    end
  end

end
