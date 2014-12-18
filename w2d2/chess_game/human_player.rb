require_relative "player.rb"
class HumanPlayer < Player
  PLAYER_HASH = { :non_filled => 'Player 2', :filled => 'Player 1'}

  def play_turn(game)
    @game = game
    @my_turn = true
    while @my_turn
      system("clear")
      # puts "Cursor: #{@cursor} | Selected: #{@selected_piece.moves unless @selected_piece.nil?}"
      game.board.print_board
      puts "#{PLAYER_HASH[self.color]}, it is your turn."
      begin
        system("stty raw -echo")
        option = STDIN.getc
        # rescue InvalidMoveError => e
        #   puts "Error: #{e.message}"
        #   retry
      ensure
        system("stty -raw echo")
      end
      game.board.cursor = game.board.cursor.dup
        case option
        when "w"
          game.board.cursor[0] -= 1 if game.board.cursor[0] > 0
        when "s"
          game.board.cursor[0] += 1 if game.board.cursor[0] < 7
        when "a"
          game.board.cursor[1] -= 1 if game.board.cursor[1] > 0
        when "d"
          game.board.cursor[1] += 1 if game.board.cursor[1] < 7
        when "q"
          return false
        when "j"
          pick_up
        when "k"
          put_down
        end
    end
    return true
  end

  def pick_up
    if !game.board[game.board.cursor].nil? && game.board.selected_piece.nil?
      if game.board[game.board.cursor].color == self.color
        game.board.selected_piece = game.board[game.board.cursor]
        game.board[game.board.cursor] = nil
      else
        puts "Not your piece"
      end
    end
  end

  def put_down
    if !game.board.selected_piece.nil? && game.board.selected_piece.moves.include?(game.board.cursor) # valid move
      unless game.board.cursor == game.board.selected_piece.moves.last # check to see if piece is put in the pick up position
        game.board.selected_piece.first_move = false if game.board.selected_piece.is_a?(Pawn)
        @my_turn = false
      end
      game.board.selected_piece.pos = game.board.cursor
      game.board[game.board.cursor] = game.board.selected_piece
      game.board.selected_piece = nil
    end
  end
end
