require_relative 'board.rb'

class MinesweeperInputError < StandardError
end

class Game
  def initialize
    @board = Board.new(*get_game_variables)
  end

  def run
    while true
      refresh
      action = get_action
      pos = get_pos
      execute(action, pos)
    end
  end

  private

  def refresh
    Kernel.system("clear")
    @board.display
  end

  def get_action
    puts "Flag or reveal?"
    gets.chomp.downcase[0]
  end

  def get_pos
    puts "Enter coordinates."
    gets.chomp.gsub(/\D/, "").split(//).map(&:to_i)
  end

  def execute(action, pos)
    case action
    when "f"
      @board.flag_tile(@board[pos])
    when "r"
      @board.reveal_tile(@board[pos])
    end
  end

  def get_length
    puts "Enter a board size!"
    length = gets.chomp.to_i
    raise MinesweeperInputError.new("Invalid size") if length <= 1

    length
  end

  def get_difficulty
    puts "Enter a difficulty [1-10]!"
    difficulty = gets.chomp.to_i
    raise MinesweeperInputError.new("Invalid difficulty") unless (1..10).include?(difficulty)

    difficulty
  end

  def get_game_variables
    begin
      length = get_length
      difficulty = get_difficulty
    rescue MinesweeperInputError => exception
      puts exception.message
      retry
    end

    [length, difficulty]
  end
end

if __FILE__ == $PROGRAM_NAME
  minesweeper = Game.new
  minesweeper.run
end
