class HumanPlayer

  attr_reader :word, :last_guess, :other_player
  attr_accessor :other_player_guesses, :word_length

  def initialize
    @word
    @other_player_guesses = {}
    @last_guess = ''
  end

  def play(other_player)

    @other_player = other_player if !!other_player
    receive_secret_length unless word_length
    other_player.check_guess(guess)
    puts other_player.status
    won?
  end

  def receive_secret_length
    self.word_length = other_player.tell_secret_length
  end

  def guess
    puts "What is your guess? (1 letter)"
    @last_guess = gets.chomp.downcase
    last_guess
  end

  def won?
    other_player.status == other_player.word
  end

  def win_message
    "You win!"
  end

end
