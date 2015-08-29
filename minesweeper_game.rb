--- !ruby/object:Game
board: &1 !ruby/object:Board
  grid:
  - - !ruby/object:Tile
      board: *1
      pos:
      - 0
      - 0
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 0
      - 1
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 0
      - 2
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 0
      - 3
      status: :revealed
      bomb: false
  - - !ruby/object:Tile
      board: *1
      pos:
      - 1
      - 0
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 1
      - 1
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 1
      - 2
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 1
      - 3
      status: :revealed
      bomb: false
  - - !ruby/object:Tile
      board: *1
      pos:
      - 2
      - 0
      status: :hidden
      bomb: true
    - !ruby/object:Tile
      board: *1
      pos:
      - 2
      - 1
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 2
      - 2
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 2
      - 3
      status: :revealed
      bomb: false
  - - !ruby/object:Tile
      board: *1
      pos:
      - 3
      - 0
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 3
      - 1
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 3
      - 2
      status: :revealed
      bomb: false
    - !ruby/object:Tile
      board: *1
      pos:
      - 3
      - 3
      status: :flagged
      bomb: true
  side_length: 4
  number_of_bombs: 2
