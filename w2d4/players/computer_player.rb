require_relative "player.rb"
class ComputerPlayer < Player
  attr_reader :board
  def play_turn(board)
    @board = board
  end
end
