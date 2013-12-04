#CLI_app
require 'debugger'
require './game_of_life.rb'

class App

  attr_accessor :world

  def initialize
    @world = World.new
  end

  # def randomly_populate



  def print_world
    puts
    puts "-"*22 + "y-axis" + "-"*25 + ">"
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

  def random
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

  def run
    random
    loop do |i|
      sleep(0.1)  
      puts "frame #{i}"
      print_world
      world.next_frame!
    end
  end
end

app = App.new
app.world.graph[10][10].alive = true
app.run

# app.run
