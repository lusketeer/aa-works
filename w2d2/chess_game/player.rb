class Player
  attr_accessor :color
  attr_reader :game

  def initialize(color)
    @color = color
    @my_turn = true
  end
end
