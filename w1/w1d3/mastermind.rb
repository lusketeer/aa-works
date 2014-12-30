class Mastermind

  def self.generate_random_choice
    colors = {
      :R => "Red",
      :G => "Green",
      :B => "Blue",
      :Y => "Yellow",
      :O => "Orange",
      :P => "Purple"
    }

    random_choice = []
    4.times do
      random_choice << colors.keys.sample.to_s
    end

    random_choice
  end

  attr_reader :computer_choice
  attr_accessor :user_choice, :guesses_left

  def initialize(guesses = 10)
    @computer_choice = self.class.generate_random_choice
    @guesses_left = guesses
  end

  def play
    until won? || guesses_left == 0
      set_user_input
      print_status
      self.guesses_left -= 1
      print_guesses unless won?
    end
    if won?
      puts "You won!"
    else
      puts "You ran out of guesses."
    end

    nil
  end

  def won?
    computer_choice == user_choice
  end

  def set_user_input
    input = " "
    loop do
      puts "Select 4 characters from \n(R, G, B, Y, O, P): "
      input = gets.chomp
      break if valid?(input)
    end
    self.user_choice = parse_user_choice(input)
  end

  def valid?(str)
    unless str.length == 4 && str =~ /[RGBYOP]{4}/i
      puts "Please exactly follow directions for selecting letters."
      return false
    else
      true
    end
  end


  def parse_user_choice(str)
    str.upcase.split(//)
  end

  def print_status
    puts "You got #{number_characters_exact} exact matches."
    puts "You got #{number_characters_near} near matches."
  end

  def print_guesses
    puts "You have #{guesses_left} guesses left."
  end

  def number_characters_included
    user_choice.select {|char| computer_choice.include?(char)}.count
  end

  def number_characters_exact
    store = 0
    user_choice.each_index do |index|
      store += 1 if user_choice[index] == computer_choice[index]
    end
    store
  end

  def number_characters_near
    number_characters_included - number_characters_exact
  end

end
