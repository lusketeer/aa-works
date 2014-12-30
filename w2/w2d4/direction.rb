module Direction
  def up
    [
      [-1, 1],
      [-1, -1]
    ]
  end

  def down
    [
      [1, 1],
      [1, -1]
    ]
  end

  def middle_pos(pos, to_pos)
    [pos, to_pos].transpose.map { |m| m.inject(:+) / m.size }
  end
end
