#game_of_life.rb

require 'awesome_print'
require 'debugger'


# How can you implement the fourth rule of Game of Life without keeping track of all the dead cells? 
# if the world doesn't care about dead cells and only tracks alive ones, how will it know when a dead 
# cell is to become alive when it has exactly three neighbors.

class Cell

  attr_accessor :x, :y, :world, :alive 

  def initialize(world, x=0,y=0)
    @x = x
    @y = y
    @world = world
    @alive = false
    world.cells << self
  end

  def neighbors
    @neighbors = []
    world.cells.each do |cell|
      if cell.alive?
        # Check for North neighbor
        if cell.x == self.x && cell.y == self.y + 1
          @neighbors << cell
        # Check for North East neighbor
        elsif cell.x == self.x + 1 && cell.y == self.y + 1
          @neighbors << cell
        # East neighbor
        elsif cell.x == self.x + 1 && cell.y == self.y
          @neighbors << cell
        # South East neighbor
        elsif cell.x == self.x + 1 && cell.y == self.y - 1
          @neighbors << cell
        # South neighbor
        elsif cell.x == self.x && cell.y == self.y - 1
          @neighbors << cell
        # South West neighbor
        elsif cell.x == self.x - 1 && cell.y == self.y - 1
          @neighbors << cell
        # West neighbor
        elsif cell.x == self.x - 1 && cell.y == self.y
          @neighbors << cell
        # North West nieghbor
        elsif cell.x == self.x - 1 && cell.y == self.y + 1
          @neighbors << cell
        end
      end
    end
    @neighbors
  end

  def dead?
    !@alive   # world does not include this instance?
  end

  def alive?
    @alive   #world does include this instance?
  end

  def spawn_at(x, y)
    world.graph[x][y].alive = true
    return world.graph[x][y]
  end

  def die!
    @alive = false 
  end

  def birth!
    @alive = true
  end

end



class World

  attr_accessor :cells, :size, :graph

  def initialize(size=20)
    @size = size
    @cells = []
    @graph = []
    populate
  end


  def populate
    size.times do |x|
      @graph << []
      size.times do |y|
        @graph[x] << Cell.new(self, x, y)
      end
    end
  end

  def birth_cell(x, y)
    graph[x][y].alive = true
    return graph[x][y]
  end

  def cell_at(x, y)
    return graph[x][y]
  end

  def next_frame!
    dead_array = []
    alive_array = []
    cells.each do |cell|
      if cell.dead? && cell.neighbors.count == 3
        alive_array << cell
      elsif cell.alive? && cell.neighbors.count < 2
        dead_array << cell
      elsif cell.alive? && cell.neighbors.count > 3
        dead_array << cell
      end
    end
    dead_array.each { |cell| cell.die! }
    alive_array.each { |cell| cell.birth!}
  end
end

