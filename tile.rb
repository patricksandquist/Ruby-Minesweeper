class Tile
  NEIGHBORS = [[0, 1], [1, 1], [1, 0], [1, -1],
               [0, -1], [-1, -1], [-1, 0], [-1, 1]]

  attr_accessor :status
  attr_reader :bomb

  def initialize(board, pos, bomb = false)
    @board = board
    @pos = pos
    @status = :uncovered # can either be uncovered, bombed, flagged, or revealed
    @bomb = bomb
  end

  def bombed?
    @status == :bombed
  end

  def flagged?
    @status == :flagged
  end

  def revealed?
    @status == :revealed
  end

  def reveal
    return :bomb if @bomb
    self.status = :revealed

    neighbor_bomb_count
  end

  def neighbor_bomb_count

    NEIGHBORS.inject(0) do |count, dis|
      x, y = dis[0] + pos[0], dis[1] + pos[1]
      count + 1 if board[[x, y]].bomb
    end

  end

end
