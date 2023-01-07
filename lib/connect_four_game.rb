# frozen_string_literal: true

# Keeps track of the game state, creates the players, and allows the turns
class Game
  attr_reader :space, :game_over, :board, :player_1, :player_2, :winner

  def initialize(player_1 = Player.new('Player 1', '⚫'), player_2 = Player.new('Player 2', '⚪'))
    @player_1 = player_1
    @player_2 = player_2
    @game_over = false
    @board = Board.new
  end

  def end_game
    @game_over = true
  end

  def declare_winner
    puts "#{@winner} wins!"
  end

  def turn(player)
    player.select(@board)
    find_four(player)

    return unless @game_over == true

    @winner = player.name
  end

  # def turn(player)
  # 	selection = player.select
  # 	@board.update(selection, player.mark)
  # 	find_four

  # 	return unless @game_over == true
  # 	@winner = player.name
  # end

  def find_four(player)
    winning_patterns = [
      [1, 2, 3, 4, 5, 6, 7],
      [8, 9, 10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19, 20, 21],
      [22, 23, 24, 25, 26, 27, 28],
      [29, 30, 31, 32, 33, 34, 35],
      [36, 37, 38, 39, 40, 41, 42],
      [1, 8, 15, 22, 29, 36],
      [2, 9, 16, 23, 30, 37],
      [3, 10, 17, 24, 31, 38],
      [4, 11, 18, 25, 32, 39],
      [5, 12, 19, 26, 33, 40],
      [6, 13, 20, 27, 34, 41],
      [7, 14, 21, 28, 35, 42],
      [15, 23, 31, 39],
      [8, 16, 24, 32, 40],
      [1, 9, 17, 25, 33, 41],
      [2, 10, 18, 26, 34, 42],
      [3, 11, 19, 27, 35],
      [4, 12, 20, 28],
      [22, 16, 10, 4],
      [29, 23, 17, 11, 5],
      [36, 30, 24, 18, 12, 6],
      [37, 31, 25, 19, 13, 7],
      [38, 32, 26, 20, 14],
      [39, 33, 27, 21]
    ]
    winning_patterns.each do |pattern|
      pattern.each_index { |number| pattern[number] = @board.space[pattern[number]] }
    end
    true_false = []
    winning_patterns.each { |pattern| pattern.each_cons(4) { |set| true_false << set.all?(player.mark) } }
    end_game if true_false.any? == true
  end

  def game_loop
    puts @board.game_board
    until @game_over == true
      turn(@player_1)
      puts @board.game_board

      break if @game_over == true

      turn(@player_2)
      puts @board.game_board
    end
    declare_winner
  end
end
