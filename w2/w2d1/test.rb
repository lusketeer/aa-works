#!/usr/bin/ruby
puts "Put something"
direction = ["a", "w", "s", "d"]
loop do
  begin
    system("stty raw -echo")
    input = STDIN.getc
  ensure
    system("stty -raw echo")
  end
  break if input == "\e"
  if direction.include?(input)
    case input
    when "w"
      puts "Up"
    when "s"
      puts "Down"
    when "a"
      puts "Left"
    when "d"
      puts "Right"
    end
  else
    p input
  end
end
