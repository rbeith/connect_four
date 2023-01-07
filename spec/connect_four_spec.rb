# frozen_string_literal: true

require '../lib/connect_four_game'
require '../lib/connect_four_player'
require '../lib/connect_four_board'

describe Game do
  describe '#winner' do
    subject(:game) { described_class.new }

    it 'declares a winner' do
      game.instance_variable_set(:@winner, 'Player 1')
      expect { game.declare_winner }.to output { 'Player 1 wins!' }.to_stdout
    end
  end

  describe '#find_four' do
    subject(:both_players) { described_class.new }
    context 'When both players have played' do
      it 'calls game_over when the first player has four in a row' do
        both_players.board.instance_variable_set(:@space, [0, '⚫', '⚫', '⚫', '⚫', '⚪', '⚪', '⚪'])
        both_players.board.space
        both_players.find_four(both_players.player_1)
        expect(both_players.game_over).to be true
      end
    end

    context 'When the first four are the same' do
      subject(:first_four) { described_class.new }
      it 'calls game_over when four in a row' do
        first_four.board.instance_variable_set(:@space, [0, '⚪', '⚪', '⚪', '⚪'])
        first_four.board.space
        first_four.find_four(first_four.player_2)
        expect(first_four.game_over).to be true
      end
    end

    context 'When there is no winner' do
      subject(:no_win) { described_class.new }
      it 'does not call game_over' do
        no_win.board.instance_variable_set(:@space, [0, '⚪', '⚫'])
        no_win.board.space
        no_win.find_four(no_win.player_1)
        expect(no_win.game_over).to be false
      end
    end
  end

  describe '#turn' do
    subject(:game) { described_class.new }

    it 'allows player to select a space and updates the board with the choice' do
      allow(game.player_1).to receive(:gets).and_return(1)
      game.turn(game.player_1)
      allow(game.player_1).to receive(:gets).and_return(2)
      game.turn(game.player_1)
      allow(game.player_1).to receive(:gets).and_return(3)
      game.turn(game.player_1)
      allow(game.player_1).to receive(:gets).and_return(4)
      game.turn(game.player_1)
      expect(game.winner).to eq(game.player_1.name)
    end
  end

  describe '#game_loop' do
    subject(:game) { described_class.new }

    it 'loops until @game_over is true' do
      allow(game).to receive(:find_four).and_return(game.end_game)
      expect(game.game_over).to be true
      game.game_loop
    end
  end
end

describe Player do
  subject(:player_1) { described_class.new('Player 1', '⚫') }

  describe '#select' do
    let(:board) { instance_double('board') }
    it 'allows a player to select a space' do
      allow(player_1).to receive(:gets).and_return(1)
      expect(board).to receive(:update).with(1, player_1.mark)
      player_1.select(board)
    end
  end
end

describe Board do
  subject(:board_update) { described_class.new }

  describe '#game_board' do
    it 'draws a game board' do
      board =
        <<-BOARD

			|  1   |  2   |  3   |  4   |  5   |  6   |  7   |
			|  8   |  9   |  10  |  11  |  12  |  13  |  14  |
			|  15  |  16  |  17  |  18  |  19  |  20  |  21  |
			|  22  |  23  |  24  |  25  |  26  |  27  |  28  |
			|  29  |  30  |  31  |  32  |  33  |  34  |  35  |
			|  36  |  37  |  38  |  39  |  40  |  41  |  42  |

        BOARD

      expect(board_update.game_board).to eq(board)
    end
  end

  describe '#update' do
    it 'updates the game board' do
      expect { board_update.update(1, '⚪') }.to change { board_update.space[1] }.to('⚪')
      board_update.update(1, '⚪')
    end

    it "doesn't update if the space is taken" do
      board_update.update(1, '⚪')
      expect { board_update.update(1, '⚫') }.to output { 'Space 1 is already taken. Try again' }.to_stdout
    end

    it 'updates when acceptable space chosen after being asked to try again' do
      board_update.update(1, '⚪')
      board_update.update(1, '⚫')
      expect { board_update.update(2, '⚫') }.to(change { board_update.space[2] })
    end
  end
end

# describe Token do
# 	subject(:token) { described_class.new }

# 	it "changes mark to white circle" do
# 		token = Token.new
# 		token.set_mark('⚫')
# 		expect(token.mark).to eq('⚫')
# 	end

# 	it "changes mark to black cicle" do
# 		token = Token.new
# 		token.set_mark('⚪')
# 		expect(token.mark).to eq('⚪')
# 	end

# end
