#game_of_life.rb

class Cell

  attr_accessor :x, :y, :world 

  def initialize(world, x=0,y=0)
    @x = x
    @y = y
    @world = world
    world.cells << self
  end

  def neighbors
    @neighbors = []
    world.cells.each do |cell|
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
    @neighbors
  end

  def dead?
    !world.cells.include?(self)   # world does not include this instance?
  end

  def alive?
    world.cells.include?(self)   #world does include this instance?
  end

  def spawn_at(x, y)
    Cell.new(world, x, y)
  end

  def die! 
    world.cells.delete_if {|cell| cell == self}
  end

end



class World

  attr_accessor :cells

  def initialize
    @cells = []
  end

  def next_frame!
    cells.each do |cell|
      if cell.neighbors.count < 2
        cell.die!
      elsif cell.neighbors.count > 3
        cell.die!
      end
    end
  end


end
