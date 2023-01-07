# frozen_string_literal: true

# player class allows players to select a space, keeps track of name and mark of player
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def select(board)
    puts "#{name}, select a space for your token '#{mark}'"
    selection = gets.to_i
    board.update(selection, mark)
  end
end
