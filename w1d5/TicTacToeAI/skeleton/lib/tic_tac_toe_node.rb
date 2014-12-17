require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos =
      board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      if board.winner == other_mark(evaluator)
        return true
      else #nil or evaluator
        return false
      end
    end

    if evaluator == next_mover_mark &&
         children.all? { |ch| ch.losing_node? evaluator }
      return true
    end

    if evaluator != next_mover_mark &&
         children.any? { |ch| ch.losing_node? evaluator }
      return true
    end

    false
  end

  def winning_node?(evaluator)
    if board.over?
      if board.winner == evaluator
        return true
      else #nil or evaluator
        return false
      end
    end

    if evaluator == next_mover_mark &&
      children.any? { |ch| ch.winning_node? evaluator }
      return true
    end

    if evaluator != next_mover_mark &&
      children.all? { |ch| ch.winning_node? evaluator }
      return true
    end

    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    board_nodes = []
    (0...3).each do |r|
      (0...3).each do |c|
        if board.empty? [r, c]
          temp_board = board.dup
          temp_board[[r, c]] = next_mover_mark
          mark = (next_mover_mark == :o) ? :x : :o
          board_nodes << TicTacToeNode.new(temp_board, mark, [r, c])
        end
      end
    end

    board_nodes
  end

  def other_mark(mark)
    (mark == :o) ? :x : :o
  end
end
empty_board_node = TicTacToeNode.new(Board.new, :x)
empty_board_node.board[[0,0]] = :o
empty_board_node.board[[0,1]] = :o
empty_board_node.board[[0,2]] = :o
empty_board_node.losing_node?(:o)
empty_board_node.losing_node?(:x)
