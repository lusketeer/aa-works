class Tile
  DELTAS = [
    [0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, -1], [-1, 1]
  ]
  attr_accessor :value, :cover, :neighbors, :pos

  def initialize(value, pos,  board)
    @pos = pos
    @value = value
    @cover = "*"
    @board = board
  end

  def bombed?
    return true if value == "B"
    false
  end

  def neighbors
    neighbor_positions = DELTAS.map do |delta|
      [pos.first + delta.first, pos.last + delta.last]
    end
    on_board_positions = neighbor_positions.select do |pos|
      pos.all?{ |coord| (0..8).cover? coord }
    end
    on_board_positions.map{ |n_pos| @board[n_pos] }
  end

  def flagged?
    return true if cover == "F"
    false
  end

  def revealed?
    return false if cover == "*" || flagged?
    true
  end

  def reveal
    return nil if flagged? || revealed?
    if bombed?
      @cover = value
      return "B"
    end
    @value = self.neighbor_bomb_count
    if value == 0
      @value = "_"
      @cover = value
      self.neighbors.each do |neighbor|
        neighbor.reveal unless neighbor.bombed?
      end
    else
      @cover = value
    end
  end

  def flag
    @cover = flagged? ? "*" : "F"
  end

  def neighbor_bomb_count
    return nil if self.bombed?
    self.neighbors.select {|neighbor| neighbor.value == "B"}.count
  end
end

class Board
  require "colorize"
  require "yaml"
  attr_accessor :tiles, :cursor
  attr_reader :bomb_seed
  def initialize
    @tiles = Array.new(9) do |row|
      Array.new(9) do |col|
        Tile.new("_", [row, col], self)
      end
    end
    @cursor = [0, 0]
    plant_bombs
  end

  def play
    puts "Welcome to minesweeper!! Have fun stepping on mines!"
    until won?
      # render_board(:value)
      # puts "========================="
      system("clear")
      render_board(:cover)
      # option = STDIN.getc #get_option
      begin
        system("stty raw -echo")
        option = STDIN.getc
      ensure
        system("stty -raw echo")
      end
      case option
      when "w"
        @cursor[0] -= 1 if @cursor[0] > 0
      when "s"
        @cursor[0] += 1 if @cursor[0] < 8
      when "a"
        @cursor[1] -= 1 if @cursor[1] > 0
      when "d"
        @cursor[1] += 1 if @cursor[1] < 8
      when "f"
        pos = @cursor #get_pos
        self[pos].flag
      when "r"
        pos = @cursor #get_pos
        outcome = self[pos].reveal
        if outcome == "B"
          system("clear")
          render_board(:cover, true)
          break
        end
      when "g"
        save_game
      when "l"
        load_game
      end
      # p "Flagged Count"
      # p flagged_tiles_count
      # p "Revealed Count"
      # p revealed_tiles_count
      # p bomb_seed
      # p won?
    end
    if won?
      puts "You won!"
    else
      puts "You died!"
      puts "Game over"
    end
  end

  def get_pos
    puts "Give us a postion within [0, 0]..[8, 8]? "
    pos = gets.chomp.scan(/\d/)
    pos.map {|coord| coord.to_i}
  end

  def get_option
    puts "Reveal (r), Flag (f), Save (s), or Load (l) ? "
    option = gets.chomp.downcase
    until ["r", "f", "s", "l"].include?(option)
      "Invalid Input"
      puts "Reveal (r), Flag (f), Save (s), or Load (l) ? "
      option = gets.chomp.downcase
    end
    option
  end

  def save_game
    puts "Give it a name: "
    filename = gets.chomp.downcase
    File.open("#{filename}.yml", "w") do |f|
      f.puts self.to_yaml
    end
  end

  def load_game
    puts "Input filename: "
    filename = gets.chomp.downcase
    new_game = YAML::load_file("#{filename}.yml")
    new_game.play
  end

  def won?
    (revealed_tiles_count + bomb_seed == 81)
  end

  def revealed_tiles_count
    tiles.inject(0) do |count, row|
      count + row.select { |tile| tile.revealed? }.count
    end
  end

  def flagged_tiles_count
    tiles.inject(0) do |count, row|
      count + row.select { |tile| tile.flagged? }.count
    end
  end

  def render_board(choice, lost = false)
    tiles.each_with_index do |row, row_index|
      print "#{row_index}: "
      row.each_with_index do |col, col_index|
        col.cover = "X" if lost && col.cover == "F" && col.value != "B"
        col.cover = col.value if lost
        output_value = col.value
        col_cover_temp = col.cover.to_s
        case col_cover_temp
        when "B"
          output_cover = col_cover_temp.white.colorize(:blink)
        when "*"
          output_cover = col_cover_temp
        when "_"
          output_cover = col_cover_temp
        when "F"
          output_cover = col_cover_temp.light_yellow
        when "1"
          output_cover = col_cover_temp.blue
        when "2"
          output_cover = col_cover_temp.green
        when "3"
          output_cover = col_cover_temp.red
        when "4"
          output_cover = col_cover_temp.white
        when "5"
          output_cover = col_cover_temp.magenta
        when "6"
          output_cover = col_cover_temp.cyan
        when "7"
          output_cover = col_cover_temp.light_blue
        when "8"
          output_cover = col_cover_temp.yellow
        end
        if @cursor == [row_index, col_index]
          print output_cover.on_white
        else
          print (choice == :value) ? output_value :  output_cover
        end
        print " "
      end
      puts ""
    end
  end

  def [](pos)
    @tiles[pos.first][pos.last]
  end

  def plant_bombs
    @bomb_seed = rand(10..27)
    bomb_seed_dup = bomb_seed
    until bomb_seed_dup == 0
      r = rand(0..8)
      c = rand(0..8)
      current_tile = self.tiles[r][c]
      # p current_tile
      if current_tile.value == "_"
        current_tile.value = "B"
        bomb_seed_dup -= 1
      end
    end
  end
end

board = Board.new
board.play
# board.render_board(:value)
# first_tile = board[[0, 0]]
# first_tile.reveal
# board.render_board(:cover)
# p "Flagged Count"
# p board.flagged_tiles_count
# p "Revealed Count"
# p board.revealed_tiles_count
