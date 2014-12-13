require "./player.rb"
class HumanPlayer < Player

  attr_reader :word, :last_guess
  attr_accessor :other_player_guesses, :word_length

  def initialize
    @word
    @other_player_guesses = {}
    @last_guess = ''
  end
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
