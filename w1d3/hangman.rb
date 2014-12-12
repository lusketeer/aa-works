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

class Player

  attr_reader :word, :last_guess
  attr_accessor :other_player_guesses, :word_length

  def initialize
    @word
    @other_player_guesses = {}
    @last_guess = ''
  end

  #guesser methods


  #checker methods


  def check_guess(guess)
    @other_player_guesses[last_guess] = word.include?(guess)
    nil
  end

  def status
    status = ""
    word.each_char do |c|
      if other_player_guesses[c]
        status << c
      else
        status << "_"
      end
    end
    status
  end

end

class ComputerPlayer < Player

  attr_accessor :dictionary

  def initialize
    @my_guesses = []
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
  end

  #methods for when I am the guesser

  def receive_secret_length
    puts "How long is your word?"
    word_length = gets.chomp.to_i
    dictionary.select! { |dictionary_word| dictionary_word.length == word_length }
    nil
  end

  def guess
    letters = "E,T,A,O,I,N,S,R,H,L,D,C,U,M,F,P,G,W,Y,B,V,K,X,J,Q,Z".split(",").map(&:downcase)
    @last_guess = letters[my_guesses.size]
    last_guess

    puts "Is #{last_guess} in your word? type your word status with underscores for"
    response = gets.chomp

  end

  def handle_guess_response(status) #J__J__
    dictionary.select! do |word|
      status.gsub!("_", )
      word =~ /#{status}/
    end
    # puts "Words left: #{dictionary.size}"
    nil
  end

  def won?
    dictionary.size == 1
  end

  #methods for when I am the checker

  def pick_secret_word
    @word = dictionary.sample
    word
  end

  def print_status

  end

  def win_message
    "Your word is #{dictionary.first}. I win!"
  end
end

class HumanPlayer < Player
  def check_guess(guess)

  end

  def guess
    puts "What is your guess? (1 letter)"
    @last_guess = gets.chomp.downcase
    last_guess
  end


  def handle_guess_response(guess_check)
    "I"
  end

  def print_status
  end

end

b = HumanPlayer.new
a = ComputerPlayer.new
game = Hangman.new(a, b)
game.play
