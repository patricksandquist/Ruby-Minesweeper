require_relative 'board.rb'

class Game
  def initialize
    @board = Board.new(*get_game_variables)
  end

  def run
    while true
      Kernel.system("clear")
      @board.display
      puts "Flag or reveal?"
      action = gets.chomp.downcase[0]
      puts "Enter coordinates."
      pos = gets.chomp.gsub(/\D/, "").split(//).map(&:to_i)
      case action
      when "f"
        @board.flag_tile(@board[pos])
      when "r"
        @board.reveal_tile(@board[pos])
      end
    end
  end

  private

  def get_game_variables
    length, difficulty = 0, 0
    until length > 1
      puts "Enter a board size!"
      length = gets.chomp.to_i
      puts "Invalid length" if length <= 1
    end
    until (1..10).include?(difficulty)
      puts "Enter a difficulty [1-10]!"
      difficulty = gets.chomp.to_i
      puts "Invalid difficulty" unless (1..10).include?(difficulty)
    end
    [length, difficulty]
  end
end

if __FILE__ == $PROGRAM_NAME
  minesweeper = Game.new
  minesweeper.run
end
