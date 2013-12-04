#gosu_display_file

require 'gosu'
require './CLI_app.rb'

class GameOfLifeWindow < Gosu::Window

  attr_accessor :size
  
  def initialize(size = 800)

    @size = size

    super size, size, false
    self.caption = "Oliver's Game of Life"


    #colors
    @white = Gosu::Color.new(0xffededed)
    @black = Gosu::Color.new(0xff121212)

    # Game
    @cells_amt = @size/10

    @cell_width = @size/@cells_amt

    @game = App.new(@cells_amt)
    # @game.world.size(@cells_amt)
    @game.randomly_populate

  end

  def update
    @game.world.next_frame!
  end

  def draw
    draw_quad(0, 0, @black,
              size, 0, @black,
              size, size, @black,
              0, size, @black,
              )

    @game.world.cells.each do |cell|
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

GameOfLifeWindow.new.show