class Tile
  attr_accessor :status

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
end
