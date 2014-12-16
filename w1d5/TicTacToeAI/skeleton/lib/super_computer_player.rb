require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    next_move_node = TicTacToeNode.new(game.board, mark)
    children = next_move_node.children
    children.each do |c|
      if c.winning_node?(mark)
        return c.prev_move_pos
      end
    end
    children.each do |c|
      if !c.losing_node?(mark)
        return c.prev_move_pos
      end
    end
    raise OurCodeIsWrongError.new \
          "There should be at least one winning or losing child node."
  end
end

class OurCodeIsWrongError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
