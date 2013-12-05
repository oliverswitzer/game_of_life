
class TerminalViz

  attr_accessor :world, :frame_time

  def initialize
  end

  def print_world
    puts
    world.graph.each do |x|
      puts
      x.each do |cell|
        if cell.alive? 
          print " * "
        else
          print " . "
        end
      end
    end
    puts
  end

  def set_game
    puts "Experiment with Conway's Game of Life! Would you like to start with an oscillator\nor a random board?"
    puts "---------------------"
    puts "\t+Type 'rand' for a random population of cells"
    puts "\t+Type 'blinker' to generate a blinker oscillator"
    puts "\t+Type 'pulsar' to generate a pulsar oscillator"
    inp = gets.chomp.downcase
    unless ['rand', 'blinker', 'pulsar'].include? inp
      puts "*** Input not recognized! ***"
      set_game
    end
    return inp
  end

  def set_frame_time
    puts "---------------------"
    puts "What frame rate would you like to run your game at? (Type in the number assosciated with the frame rate)"
    puts "---------------------"
    puts "\t[1] - 1 Second/Frame"
    puts "\t[2] - 0.5 Second/Frame"
    puts "\t[3] - 0.1 Second/Frame"
    inp = Integer(gets) rescue nil
    if inp.nil? || inp.to_i > 3 || inp.to_i < 1
      set_frame_time
      "You either didn't enter an integer or the number you entered didn't correspond to a frame rate."
    end

    case inp 
    when 1
      1
    when 2
      0.5
    when 3
      0.1
    end
  end

  def get_user_params
    game_type = set_game
    frame_time = set_frame_time

    return { :game_type => game_type, 
             :frame_time => frame_time }
  end

  def run
    loop do |i|
      sleep(frame_time)  
      puts "frame #{i}"
      print_world
      world.next_frame!
    end
  end

end

