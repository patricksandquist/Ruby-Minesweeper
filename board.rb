class Board
  def [](pos)
    row, col = pos[0], pos[1]
    @rows[row][col]
  end

  def []=(pos, mark)
    raise "mark already placed there!" unless empty?(pos)

    row, col = pos[0], pos[1]
    @rows[row][col] = mark
  end
end
