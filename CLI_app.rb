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
    world.graph.each do |x|
      puts
      x.each do |cell|
        if cell.alive? 
          print "*"
        else
          print "."
        end
        # print "(#{cell.x}, #{cell.y}) "
      end
    end
    puts
  end


  def run
    world.graph[9][10].alive = true
    world.graph[10][10].alive = true
    world.graph[11][10].alive = true
    10.times do |i|
      sleep(0.4)  
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
