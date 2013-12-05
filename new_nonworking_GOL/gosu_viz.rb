
require 'gosu'
require 'debugger'
require_relative "game"

class GosuViz < Gosu::Window

  attr_accessor :world, :size
  
  def initialize(size = 200)

    @size = size

    # Game window
    super size, size, false
    self.caption = "Oliver's Game of Life"


    # Colors
    @white = Gosu::Color.new(0xffededed)
    @black = Gosu::Color.new(0xff121212)

    # Game
    @cells_amt = @size/10
    @cell_width = @size/@cells_amt
    @game = Game.new(@size)
    @world = @game.world
    @game.randomly_populate

  end

  def update
    @world.next_frame!
  end

  def draw
    draw_quad(0, 0, @black,
              size, 0, @black,
              size, size, @black,
              0, size, @black,
              )

    world.cells.each do |cell|
      if cell.alive?
        draw_quad(
                  cell.x * @cell_width, cell.y * @cell_width, @white,
                  cell.x * @cell_width, cell.y*@cell_width + @cell_width, @white,
                  cell.x*@cell_width + @cell_width, cell.y*@cell_width + @cell_width, @white,
                  cell.x*@cell_width + @cell_width, cell.y*@cell_width, @white
                  ) 
      end
    end

  end

  def needs_cursor?; true; end

end
GosuViz.new.show