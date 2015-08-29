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
    game_over if !tile.flagged? && tile.bombed?
    if value == 0
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
    print "       "
    (0...@side_length).each do |i|
      print '%-3s' % i
    end
    puts
    puts "     #{"-" * @side_length * 3}--"
    @grid.each_with_index do |row, idx|
      print '%3s' % idx + " |  "
      row.each do |el|
        print "#{el.to_s}  "
      end
      puts "| #{idx}"
    end
    puts "     #{"-" * @side_length * 3}--"
    print "       "
    (0...@side_length).each do |i|
      print '%-3s' % i
    end
    puts

    nil
  end

  private

  def populate_grid
    @grid.map!.with_index do |row, i|
      row.map!.with_index do |el, j|
        Tile.new(self, [i,j])
      end
    end

    add_bombs
  end

  def add_bombs
    range = (0...side_length).to_a
    all_positions = range.product(range)
    bomb_positions = all_positions.sample(@number_of_bombs)

    bomb_positions.each { |pos| self[pos].bomb = true }
  end

  def game_over
    display
    Kernel.abort("You lose!")
  end

  def won?
    @grid.each do |row|
      row.each do |el|
        return false if el.flagged? && !el.bomb
      end
    end
    flagged_and_unhidden = 0
    @grid.each do |row|
      row.each do |el|
        flagged_and_unhidden += 1 if el.flagged? || !el.hidden?
      end
    end
    return true if flagged_and_unhidden == side_length ** 2 - @number_of_bombs

    false
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
