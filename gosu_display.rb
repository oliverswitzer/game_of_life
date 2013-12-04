#gosu_display_file

require 'gosu'

class GameOfLifeWindow < Gosu::Window
  def initialize(height=800, width=600)

    @height = height
    @width = width
    
    super 800, 600, false
    self.caption = "Oliver's Game of Life"


    #colors
    @white = Gosu::Color.new(0xffededed)
    @black = Gosu::Color.new(0xff121212)

    # game world
    @rows = height/10
    @cols = width/10
    @row_height = height/@rows
    @col_height = width/@cols
  end

  def update
  end

  def draw

  end

end

GameOfLifeWindow.new.show