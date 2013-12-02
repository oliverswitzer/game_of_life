#game_of_life_spec.rb
require 'debugger'
require_relative 'spec_helper'
require_relative 'game_of_life'

describe "game of life" do

  let(:world) { World.new }

  context "cell methods" do
    subject {Cell.new(world)}
    it "should spawn another cell relative to itself" do
      cell = subject.spawn_at(3,5)
      cell.is_a?(Cell).should be_true
      cell.x.should == 3
      cell.y.should == 5
      cell.world.should == subject.world
    end

    it "should detect a neighbor to its north" do
      # debugger
      cell = subject.spawn_at(0, 1)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its north east" do
      cell = subject.spawn_at(1,1)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its east" do
      cell = subject.spawn_at(1,0)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its south east" do
      cell = subject.spawn_at(1,-1)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its south" do
      cell = subject.spawn_at(0,-1)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its south west" do
      cell = subject.spawn_at(-1,-1)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its west" do
      cell = subject.spawn_at(-1,0)
      subject.neighbors.count.should == 1
    end
    it "should detect a neighbor to its north west" do
      cell = subject.spawn_at(-1,1)
      subject.neighbors.count.should == 1
    end

    it "dies" do
      subject.die!
      world.cells.should_not include(subject)
    end

  end

  it "Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
    cell = Cell.new(world)
    cell.spawn_at(2, 0)
    cell.neighbors.count.should == 0
    world.next_frame!
    cell.should be_dead
  end

  it "Rule 2: Any live cell with two or three live neighbours lives on to the next generation." do
    cell = Cell.new(world)
    new_cell0 = cell.spawn_at(1, 0)
    new_cell1 = cell.spawn_at(1, 1)
    cell.neighbors.count.should == 2
    world.next_frame!
    cell.should be_alive
  end

  it "Rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding." do
    cell = Cell.new(world)
    new_cell0 = cell.spawn_at(1,0)
    new_cell1 = cell.spawn_at(1, 1)  
    new_cell2 = cell.spawn_at(1, -1)
    new_cell3 = cell.spawn_at(-1, 0)
    cell.neighbors.count.should == 4
    world.next_frame!
    cell.should be_dead
  end

  it "Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction." do
    cell = Cell.new(world)
    new_cell0 = cell.spawn_at(1,0) 
    new_cell1 = cell.spawn_at(1, 1)  
    new_cell2 = cell.spawn_at(1, -1)
    cell.neighbors.count.should == 3
    world.next_frame!
    cell.should be_alive
  end
end





