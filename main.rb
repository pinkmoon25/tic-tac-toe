# frozen_string_literal: true

require_relative 'lib/game'

def main
  game = Game.new
  puts " Let's Play! "
  game.board
  puts " Who goes first: 'X' or 'O'?"

  current_symbol = pick_turn
  play(current_symbol, game)

  puts game.end_game?
rescue StandardError
  puts ' Alright See Ya Later!'
rescue Interrupt
  puts ' Alright See Ya Later!'
end

def pick_turn
  current_symbol = nil
  loop do
    user_input = gets.chomp.upcase
    if %w[X O].include?(user_input)
      current_symbol = user_input
      break
    else
      puts " Invalid input! Please choose 'X' or 'O'."
    end
  end
  current_symbol
end

def play(symbol, game)
  loop do
    puts " #{symbol}'s turn: Pick a spot"
    value = gets.chomp.to_i
    if value.between?(1, 9) && game.update_board(value.to_s, symbol)
      game.board
      break if game.end_game?

      symbol = symbol == 'X' ? 'O' : 'X'
    else
      puts ' Invalid move! Please pick an empty spot (1-9).'
    end
  end
end

main
