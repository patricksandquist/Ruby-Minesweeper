class Tile
  NEIGHBORS = [[0, 1], [1, 1], [1, 0], [1, -1],
               [0, -1], [-1, -1], [-1, 0], [-1, 1]]

  attr_reader :bomb, :status

  def initialize(board, pos, bomb = false)
    @board = board
    @pos = pos
    @status = :hidden # can either be hidden, bombed, flagged, or revealed
    @bomb = bomb
  end

  def bombed?
    @status == :bombed
  end

  def flagged?
    @status == :flagged
  end

  def hidden?
    @status == :hidden
  end

  def revealed?
    @status == :revealed
  end

  def reveal
    return :flagged if flagged?
    return :bomb if @bomb
    @status = :revealed

    neighbor_bomb_count
  end

  def flag
    @status = :flagged
  end

  def neighbor_bomb_count
    neighbors.count { |neighbor| neighbor.bomb }
  end

  def neighbors
    NEIGHBORS.map do |dis|
      x, y = dis[0] + pos[0], dis[1] + pos[1]
      next if x < 0 || y < 0 || x > 8 || y > 8
      board[[x, y]]
    end
  end

  def to_s
    return "F" if flagged?
    return "B" if bombed?
    return "*" if hidden?
    return "_" if revealed? && neighbor_bomb_count.zero?
    return "#{neighbor_bomb_count}"
  end

end
