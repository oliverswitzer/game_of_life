#game_of_life_spec.rb
require 'debugger'
require_relative 'spec_helper'
require_relative 'game_of_life'

describe "game of life" do

  let(:world) { World.new.tap {|world| world.size = 20} }

  context "cell utility methods" do
    subject { world.graph[10][10].tap {|cell| cell.alive = true} }
    it "should spawn another cell relative to itself" do
      cell = subject.spawn_at(11,12)
      cell.is_a?(Cell).should be_true
      cell.x.should == 11
      cell.y.should == 12
      cell.world.should == subject.world
      cell.should == world.graph[11][12]
      world.graph[11][12].should be_alive
    end

    it "should detect a neighbor to its north" do
      # debugger
      cell = subject.spawn_at(10, 11)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its north east" do
      cell = subject.spawn_at(11,11)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its east" do
      cell = subject.spawn_at(11,10)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its south east" do
      cell = subject.spawn_at(11,9)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its south" do
      cell = subject.spawn_at(10,9)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its south west" do
      cell = subject.spawn_at(9,9)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its west" do
      cell = subject.spawn_at(9,10)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its north west" do
      cell = subject.spawn_at(9,11)
      subject.neighbors.count.should == 1
    end

  end

  context "world utility methods" do
    it "cell_at should return the cell at x-y coords specified" do
      world.cell_at(10, 10).should == world.graph[10][10]
    end

    it "a new world should populate itself with dead cells" do 
      world.cells.should_not be_empty 
      world.cells.count.should == world.size**2
      world.cells.all? {|cell| cell.alive? == false}.should be_true
    end

    it "a world can birth a cell at any place in the world" do 
      world.birth_cell(10, 10)
      world.graph[10][10].should be_alive
    end

  end

  it "Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
    cell = world.graph[10][10].tap {|cell| cell.alive = true}
    cell.spawn_at(12, 0)
    cell.neighbors.count.should == 0
    world.next_frame!
    cell.should be_dead
  end

  it "Rule 2: Any live cell with two or three live neighbours lives on to the next generation." do
    cell = world.graph[10][10].tap {|cell| cell.alive = true}
    new_cell0 = cell.spawn_at(11, 11)
    new_cell1 = cell.spawn_at(10, 11)
    cell.neighbors.count.should == 2
    world.next_frame!
    cell.should be_alive
  end

  it "Rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding." do
    cell = world.graph[10][10].tap {|cell| cell.alive = true}
    new_cell0 = cell.spawn_at(11,10)
    new_cell1 = cell.spawn_at(11, 11)  
    new_cell2 = cell.spawn_at(11, 9)
    new_cell3 = cell.spawn_at(9, 10)
    cell.neighbors.count.should == 4
    world.next_frame!
    cell.should be_dead
  end

  it "Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction." do
    cell = world.graph[10][10].tap {|cell| cell.alive = false}
    new_cell0 = cell.spawn_at(10, 11) 
    new_cell1 = cell.spawn_at(11, 11)  
    new_cell2 = cell.spawn_at(11, 10)
    cell.neighbors.count.should == 3
    # debugger
    world.next_frame!
    cell.should be_alive
  end


  it "Game can make a blinker oscillator" do
    world.birth_cell(10, 9)
    world.birth_cell(10, 10)
    world.birth_cell(10, 11)
    world.next_frame!
    world.cell_at(11, 10).should be_alive
    world.cell_at(10, 10).should be_alive
    world.cell_at(9, 10).should be_alive
    world.next_frame!
    world.cell_at(10, 9).should be_alive
    world.cell_at(10, 10).should be_alive
    world.cell_at(10, 11).should be_alive
  end

end





