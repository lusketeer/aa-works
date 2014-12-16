class Cat
  def initialize(name, age, city)
    @name, @age, @city = name, age, city
  end
end

require "yaml"
# c = Cat.new("Breakfast", 8, "San Francisco")
# File.open("test.yml", "w") do |f|
#   f.puts c.to_yaml
# end


c2 = YAML::load_file("test.yml")
p c2
