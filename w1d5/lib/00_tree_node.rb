class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(val, parent = nil)
    @value = val
    @children = []
    @parent = parent
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

  def root?
    self.parent.nil?
  end
end
