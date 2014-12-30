require "curses"
include Curses

def get_key
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

end
def show_message(message)
  width = message.length + 6
  win = Window.new(5, width,
  (lines - 5) / 2, (cols - width) / 2)
  win.box(?|, ?-)
  win.setpos(2, 3)
  win.addstr(message)
  win.refresh
  win.getch
  win.close
end

init_screen
begin
  crmode
  #  show_message("Hit any key")
  setpos((lines - 5) / 2, (cols - 10) / 2)
  addstr("Hit any key")
  refresh
  getmouse
  show_message("Hello, World!")
  refresh
ensure
  close_screen
end
