require_relative "00_tree_node.rb"

class MazeSolver
  DELTAS = [
    [0,1],[0,-1],[1,0],[-1,0],
    [1,1],[1,-1],[-1,1],[-1,-1]
  ]

  attr_reader :start, :exit, :maze, :tree
  attr_accessor :visited_positions
  WALL = '█'
  PATH = "•"

  def initialize(maze_file_name)
    @maze = File.readlines(maze_file_name).map do |line|
      line.gsub('*',WALL).chomp.split("")
    end
    @maze.each_index do |row|
      @maze.first.each_index do |col|
        @start = PolyTreeNode.new([row, col]) if @maze[row][col] == "S"
        @exit = PolyTreeNode.new([row, col]) if @maze[row][col] == "E"
      end
    end
    @visited_positions = [start]
  end

  def find_path(end_pos)
    end_node = tree.dfs(end_pos.value)
    end_node.trace_path_back
  end

  def new_move_positions(pos)
    positions = valid_moves(pos) - visited_positions
    self.visited_positions += positions
    positions
  end

  def valid_moves(pos)
    DELTAS.map do |delta|
      [pos.first + delta.first, pos.last + delta.last]
    end.select do |r, c|
      num_rows = maze.length
      num_cols = maze.first.length
      (0..num_rows).include?(r) && (0..num_cols).include?(c) &&
          maze[r][c] != WALL
    end
  end

  def build_move_tree
    root = start
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

  def print_maze(path = [])
    maze.each_index do |r|
      maze.first.each_index do |c|
        print (path.include?([r, c])) ? PATH : maze[r][c]
      end
      puts
    end
  end
end

m = MazeSolver.new("maze1.txt")
m.print_maze
m.build_move_tree
result = m.find_path(m.exit)
m.print_maze(result)
