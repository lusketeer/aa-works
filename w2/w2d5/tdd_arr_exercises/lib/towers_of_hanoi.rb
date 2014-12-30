class Tower
  attr_reader :win_stack
  attr_accessor :stacks
  def initialize(n = 3)
    discs = []
    n.downto(1) do |i|
      discs << i
    end
    @win_stack = discs
    @stacks = {1 => discs, 2 => [], 3 => []}
  end

  def move_disk(start_tower, end_tower)
    if stacks[start_tower].empty? || (!stacks[end_tower].empty? && stacks[start_tower].last > stacks[end_tower].last)
      raise RuntimeError.new "Invalid move"
    end
    # raise "Invalid move" if stacks[start_tower].last > stacks[end_tower].last
    disk = stacks[start_tower].pop
    return true if stacks[end_tower].push(disk)
  end

  def over?
    stacks[3] == win_stack
  end

  def play
    until over?
      # loop for user input to move disk
    end
  end
end
