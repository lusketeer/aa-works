def game
  puts "How many disks do you want to try?"
  difficulty = gets.chomp.to_i

  while difficulty < 3
    puts "Please select a number greater than 3!"
    difficulty = gets.chomp
  end

  solution = (1..difficulty).to_a.reverse
  poles = {
    "1" => (1..difficulty).to_a.reverse,
    "2" => [],
    "3" => []
  }

  while poles["3"] != solution

    status(poles["1"], poles["2"], poles["3"])

    moving_disk = 0

    while moving_disk == 0
      puts "Where do you want to move the disk from? Say 1, 2, or 3"
      pole_from = gets.chomp
      moving_disk = poles[pole_from].pop if %w(1 2 3).include?(pole_from)
    end

    status(poles["1"], poles["2"], poles["3"])
    puts "Disk #{moving_disk} is selected"

    while moving_disk != 0
      puts "Where do you want to move the disk to? Say 1, 2, or 3"
      pole_to = gets.chomp
      pole_to_pole = poles[pole_to]
      if pole_to_pole.empty? || pole_to_pole.last > moving_disk
        pole_to_pole.push(moving_disk)
        moving_disk = 0
      end
    end

  end

  puts "You win!"
end

def status(pole_one, pole_two, pole_three)
  puts "Pole 1 has #{pole_one.join(', ')} disks"
  puts "Pole 2 has #{pole_two.join(', ')} disks"
  puts "Pole 3 has #{pole_three.join(', ')} disks"
end

game
