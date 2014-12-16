class ComputerPlayer
  attr_reader :word, :last_guess
  attr_accessor :other_player_guesses, :word_length, :dictionary

  def initialize
    @word
    @other_player_guesses = {}
    @last_guess = ''
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

  def win_message
    "Your word is #{dictionary.first}. I win!"
  end
end
