require_relative 'tile.rb'

class Board
  NUMBER_OF_BOMBS = 12

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    populate_grid
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @grid[row][col]
  end

  def reveal_tile(tile)
    value = tile.reveal
    tile.neighbors.each { |neighbor| reveal_tile(neighbor) } if value.zero?

    value # flagged, bomb, or number of neighboring bombs
  end

  def display
    @grid.each do |row|
      row.each do |el|
        print "#{el.to_s} "
      end
      print "\n"
    end

    nil
  end

  private

  def populate_grid
    @grid.map!.with_index do |row, i|
      row.map!.with_index do |el, j|
        Tile.new(self, [i,j])
      end
    end
    NUMBER_OF_BOMBS.times { add_bomb }
  end

  def add_bomb
    i, j = (0..8).to_a.sample, (0..8).to_a.sample
    while self[[i, j]].bomb
      i, j = (0..8).to_a.sample, (0..8).to_a.sample
    end

    @grid[i][j] = Tile.new(self, [i, j], true)
  end


end
