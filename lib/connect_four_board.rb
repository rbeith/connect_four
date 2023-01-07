# frozen_string_literal: true

# Creates the game board, keeps track of the spaces, and updates the spaces on the board.
class Board
  attr_reader :space

  def initialize(space = (0..42).to_a)
    @space = space
  end

  # def create_spaces
  # 	@space.each { |number| Space.new(number) }
  # end

  # def game_board
  # 	arr = 6.times { |n| puts n}
  # 	p arr
  # end

  def game_board(space = @space)
    <<-BOARD

			|  #{space[1]}   |  #{space[2]}   |  #{space[3]}   |  #{space[4]}   |  #{space[5]}   |  #{space[6]}   |  #{space[7]}   |
			|  #{space[8]}   |  #{space[9]}   |  #{space[10]}  |  #{space[11]}  |  #{space[12]}  |  #{space[13]}  |  #{space[14]}  |
			|  #{space[15]}  |  #{space[16]}  |  #{space[17]}  |  #{space[18]}  |  #{space[19]}  |  #{space[20]}  |  #{space[21]}  |
			|  #{space[22]}  |  #{space[23]}  |  #{space[24]}  |  #{space[25]}  |  #{space[26]}  |  #{space[27]}  |  #{space[28]}  |
			|  #{space[29]}  |  #{space[30]}  |  #{space[31]}  |  #{space[32]}  |  #{space[33]}  |  #{space[34]}  |  #{space[35]}  |
			|  #{space[36]}  |  #{space[37]}  |  #{space[38]}  |  #{space[39]}  |  #{space[40]}  |  #{space[41]}  |  #{space[42]}  |

    BOARD
  end

  def update(selection, mark)
    until @space[selection] == selection
      puts "Space #{selection} is already taken. Try again."
      selection = gets.to_i
    end
    @space[selection] = mark
  end
end
