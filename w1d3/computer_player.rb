
class ComputerPlayer
  attr_reader :word, :last_guess
  attr_accessor :other_player_guesses, :word_length
  attr_accessor :dictionary, :other_user_response, :my_guesses

  def initialize
    @word
    @other_player_guesses = {}
    @last_guess = ''
    @my_guesses = []
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @other_user_response = ''
  end

  #methods for when I am the guesser

  def play(other_player)
    receive_secret_length unless word_length
    guess
    handle_guess_response
    won?
  end

  def receive_secret_length
    puts "How long is your word?"
    self.word_length = gets.chomp.to_i
    dictionary.select! { |dictionary_word| dictionary_word.length == word_length }
    nil
  end

  def guess
    letters = "E,T,A,O,I,N,S,R,H,L,D,C,U,M,F,P,G,W,Y,B,V,K,X,J,Q,Z".split(",").map(&:downcase)
    @last_guess = letters[my_guesses.size]
    my_guesses << last_guess
    puts "Is #{last_guess} in your word? Type your word status with underscores for all other letters."
    self.other_user_response = gets.chomp
  end

  def handle_guess_response
    dictionary.select! do |word|
      other_user_response.gsub!("_", ".")
      word =~ /#{other_user_response}/
    end
    p "Words left: #{dictionary.size}"
  end

  def won?
    dictionary.size == 1
  end

  #methods for when I am the checker

  def pick_secret_word
    @word = dictionary.sample
    word
  end

  def tell_secret_length
    word.length
  end

  def print_status

  end

  def win_message
    "Your word is #{dictionary.first}. I win!"
  end

  def check_guess(guess)
    other_player_guesses[guess] = word.include?(guess)
    word.include?(guess)
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
