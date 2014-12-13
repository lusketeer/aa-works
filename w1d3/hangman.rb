require "./human_player.rb"
require "./computer_player.rb"
class Hangman
  attr_reader :guessing_player, :checking_player

  def initialize(guessing_player, checking_player)
    @guessing_player, @checking_player = guessing_player, checking_player
  end

  def play
    guessing_player.receive_secret_length
    until won?
      turn
    end
    puts guessing_player.win_message
  end

  def turn
    checking_player.pick_secret_word unless checking_player.word
    p checking_player.word
    guess = guessing_player.guess
    checking_player.check_guess(guess)
    status = checking_player.status
    guessing_player.handle_guess_response(status)
    # p guessing_player.dictionary.first(10)
  end

  def won?
    guessing_player.won?
  end


end
b = HumanPlayer.new
a = ComputerPlayer.new
game = Hangman.new(a, b)
game.play
