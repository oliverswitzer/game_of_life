#CLI_app
require 'debugger'
require './game_of_life.rb'

class App

  attr_accessor :world

  def initialize(size=20)
    @world = World.new(size)
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

  def blinker
    world.birth_cell(10, 9)
    world.birth_cell(10, 10)
    world.birth_cell(10, 11)
  end

  def pulsar
    world.birth_cell(10, 7)
    world.birth_cell(9, 8)
    world.birth_cell(11, 8)
    world.birth_cell(9, 9)
    world.birth_cell(11, 9)
    world.birth_cell(10, 10)
    world.birth_cell(9, 11)
    world.birth_cell(11, 11)
    world.birth_cell(9, 12)
    world.birth_cell(11, 12)
    world.birth_cell(10, 13)
  end

  def randomly_populate
    rand(1..world.size**2).times do 
      world.birth_cell(rand(0..world.size-1), rand(0..world.size-1))
    end
  end

  def glider
    #currently doesn't work!
    world.birth_cell(9, 9)
    world.birth_cell(9, 10)
    world.birth_cell(9, 11)
    world.birth_cell(10, 11)
    world.birth_cell(11, 10)
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

  def set_frame_rate
    puts "---------------------"
    puts "What frame rate would you like to run your game at? (Type in the number assosciated with the frame rate)"
    puts "---------------------"
    puts "\t[1] - 1 Second/Frame"
    puts "\t[2] - 0.5 Second/Frame"
    puts "\t[3] - 0.1 Second/Frame"
    inp = Integer(gets) rescue nil
    if inp.nil? || inp.to_i > 3 || inp.to_i < 1
      set_frame_rate
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

  def run
    game_type = set_game
    frame_rate = set_frame_rate
    case game_type
    when 'rand'
      randomly_populate
    when 'blinker'
      blinker
    when 'pulsar'
      pulsar
    end
  
    loop do |i|
      sleep(frame_rate)  
      puts "frame #{i}"
      print_world
      world.next_frame!
    end
  end
end

# app = App.new
# app.run

# app.run
