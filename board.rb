class Board
  NUMBER_OF_BOMBS = 12

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    populate_grid
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @rows[row][col]
  end
  #
  # def []=(pos, mark)
  #   raise "mark already placed there!" unless empty?(pos)
  #
  #   row, col = pos[0], pos[1]
  #   @rows[row][col] = mark
  # end

  private

  def populate_grid
    @grid.map_with_index! do |row, i|
      row.map_with_index! do |el, j|
        Tile.new(self, [i,j])
      end
    end
    NUMBER_OF_BOMBS.times { add_bomb }
  end

  def add_bomb
    i, j = (0..8).to_a.sample, (0..8).to_a.sample
    while self.[[i, j]].bomb
      i, j = (0..8).to_a.sample, (0..8).to_a.sample
    end

    @grid[i][j] = Tile.new(self, [i, j], true)
  end

  
end
