require_relative 'tile.rb'

class Board
  attr_reader :side_length

  def initialize(side_length, difficulty = 5)
    @grid = Array.new(side_length) { Array.new(side_length) }
    @side_length = side_length
    @number_of_bombs = (difficulty * (side_length ** 2)) / 50 + 1
    populate_grid
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @grid[row][col]
  end

  def reveal_tile(tile)
    value = tile.reveal
    game_over if tile.bombed?
    if value.zero?
      tile.neighbors.each do |neighbor|
        reveal_tile(neighbor) unless neighbor.revealed?
      end
    end

    value # flagged, bomb, or number of neighboring bombs
  end

  def flag_tile(tile)
    tile.flag
    winner if won?
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
    @number_of_bombs.times { add_bomb }
  end

  def add_bomb
    i, j = (0...side_length).to_a.sample, (0...side_length).to_a.sample
    while self[[i, j]].bomb
      i, j = (0...side_length).to_a.sample, (0...side_length).to_a.sample
    end

    @grid[i][j] = Tile.new(self, [i, j], true)
  end

  def game_over
    display
    Kernel.abort("You lose!")
  end

  def won?
    @grid.each do |row|
      row.each do |el|
        return false if (el.flagged? && !el.bomb) || (el.bomb && !el.flagged?)
      end
    end

    true
  end

  def winner
    @grid.each do |row|
      row.each do |el|
        reveal_tile(el) unless el.flagged?
      end
    end
    display
    Kernel.abort("You win!")
  end

end
