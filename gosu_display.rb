#gosu_display_file

require 'gosu'

class GameOfLifeWindow < Gosu::Window
  def initialize
    super 800, 600, false
    self.caption = "Oliver's Game of Life"
  end

  def update
  end

  def draw
  end

end

GameOfLifeWindow.new.show