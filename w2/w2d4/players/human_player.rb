require_relative "player.rb"
class HumanPlayer < Player
  SYMBOLS = { white: "○",  black: "●" }
  attr_reader :board

  def initialize(name, color)
    super(name, color)
  end

  def play_move(board)
    @board = board
    @my_turn = true
    while @my_turn
      system("clear")
      board.render
      puts "#{name.capitalize}'s turn: #{SYMBOLS[color]}"
      puts "Piece on Hand: #{board.selected_piece.render unless board.selected_piece.nil?}, Move Seq: #{board.seq_moves}"
      # puts "Valid Moves: #{board.selected_piece.valid_moves unless board.selected_piece.nil?}"
      begin
        system("stty raw -echo")
        option = STDIN.getc
      ensure
        system("stty -raw echo")
      end
      board.cursor = board.cursor.dup
      case option
      when "w"
        board.cursor[0] -= 1 if board.cursor[0] > 0
      when "s"
        board.cursor[0] += 1 if board.cursor[0] < board.size - 1
      when "a"
        board.cursor[1] -= 1 if board.cursor[1] > 0
      when "d"
        board.cursor[1] += 1 if board.cursor[1] < board.size - 1
      when "q"
        return false
      when "j"
        pick_up
      when "k"
        put_down
        board.seq_moves = [] # reset seq moves after a turn
      end

    end
    true
  end

  def pick_up # pick up the piece || add coordinate when already have a piece in hand
    if !board.empty?(board.cursor) && board[board.cursor].color == self.color && board.selected_piece.nil?
      board.selected_piece = board[board.cursor]
      # board[board.cursor] = nil
    elsif board.empty?(board.cursor) && !board.selected_piece.nil?
      if board.selected_piece.pos != board.cursor # && (board.selected_piece.valid_moves.include?(board.cursor)) # don't add current position
        if board.seq_moves.include?(board.cursor)
          board.seq_moves -= [board.cursor]
        else
          board.seq_moves << board.cursor
        end
      end
    end
  end

  def put_down
    if !board.selected_piece.nil? #&& (board.selected_piece.valid_moves.include?(board.cursor))
      if board.selected_piece.pos == board.cursor # return piece back to original position
        board.selected_piece = nil
      else
        piece_pos = board.selected_piece.pos
        begin
          board[piece_pos].perform_moves(board.seq_moves)
          board.selected_piece = nil
          @my_turn = false
          board.seq_moves = []
        rescue => e
          puts e.message
          @my_turn = true
          return
        end
      end
    end

  end


end
