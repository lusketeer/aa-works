class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(val)
    @value = val
    @children = []
    @parent = nil
  end

  def parent=(parent_node)
    old_parent = @parent
    old_parent.children.delete(self) unless old_parent.nil?
    @parent = parent_node
    unless parent_node.nil? || parent_node.children.include?(self)
      parent_node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    unless children.include? child_node
      raise "Node isn't a child; can't remove"
    end

    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    return nil if children.empty?

    children.each do |child_node|
      result = child_node.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    q = [self]
    until q.empty?
      node = q.shift
      return node if node.value == target_value
      q += node.children
    end
    nil
  end

  def trace_path_back
    return [self.value] if self.root?
    parent.trace_path_back + [self.value]
  end

  def print_tree
    print "  " * (trace_path_back.length - 1)
    p self.value
    self.children.each do |ch|
      ch.print_tree
    end
  end

  def root?
    self.parent.nil?
  end

  def count
    return 1 if children.empty?
    sum = 1
    children.each do |ch|
      sum += ch.count
    end
    sum
  end
end

class KnightPathFinder
  attr_reader :start_pos, :tree
  attr_accessor :visited_positions

  def initialize(pos)
    @start_pos = pos
    @visited_positions = [start_pos]
  end

  def find_path(end_pos)
    end_node = tree.dfs(end_pos)
    end_node.trace_path_back
  end

  def new_move_positions(pos)
    positions = self.class.valid_moves(pos) - visited_positions
    self.visited_positions += positions
    positions
  end

  def self.valid_moves(pos)
    deltas = [
      [1, 2], [1, -2], [-1, 2], [-1, -2],
      [2, 1], [2, -1], [-2, 1], [-2, -1]
    ]

    deltas.map do |delta|
      [pos.first + delta.first, pos.last + delta.last]
    end.select do |x, y|
      (0..7).include?(x) && (0..7).include?(y)
    end
  end

  def build_move_tree
    root = PolyTreeNode.new(start_pos)
    q = [root]
    until q.empty?
      node = q.shift
      new_move_positions(node.value).each do |new_pos|
        child_node = PolyTreeNode.new(new_pos)
        child_node.parent = node
        q << child_node
      end
    end
    @tree = root
  end
end

k = KnightPathFinder.new([0, 0])
root = k.build_move_tree
root.print_tree
p k.find_path([7, 6])
