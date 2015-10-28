require_relative 'board.rb'
require 'yaml'

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
    gets.chomp.split(",").map { |el| el.gsub(/\D/, "").to_i }
  end

  def execute(action, pos)
    # debugger
    case action
    when "f"
      @board.flag_tile(@board[pos])
    when "r"
      @board.reveal_tile(@board[pos])
    when "s"
      save
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

  def save
    puts "Enter a file name"
    filename = gets.chomp
    File.write(filename, self.to_yaml)

    Kernel.abort("Goodbye!")
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    minesweeper = Game.new
    minesweeper.run
  else
    serialized_game = File.read(ARGV.shift)
    minesweeper = YAML::load(serialized_game)
    minesweeper.run
  end
end
