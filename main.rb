# frozen_string_literal: true

require 'colorize'
require_relative 'lib/game'

def main
  game = Game.new
  puts " Let's Play! ".bold.italic.light_yellow
  game.board

  current_turn = pick_side

  play(current_turn, game)

  puts game.end_game?.bold.light_green.blink_slow
rescue StandardError
  puts ' Alright See Ya Later!'.bold.light_white
rescue Interrupt
  puts ' Alright See Ya Later!'.bold.light_white
end

def pick_side
  puts " #{'Who goes first:'.bold.light_blue} #{'X'.bold.red} or #{'O'.bold.green}?"
  current_turn = nil
  loop do
    user_input = gets.chomp.upcase
    if %w[X O].include?(user_input)

      current_turn = user_input
      break
    else
      puts " Invalid input! Please choose 'X' or 'O'.".light_red.italic
    end
  end
  current_turn.downcase == 'x' ? current_turn.bold.red : current_turn.bold.green
end

def play(symbol, game)
  loop do
    puts " #{symbol}" + "'s turn : Pick a spot".bold.gray
    value = gets.chomp.to_i

    if value.between?(1, 9) && game.update_board(value.to_s, symbol)
      game.board
      break if game.end_game?

      symbol = symbol.uncolorize.upcase == 'X' ? 'O'.bold.green : 'X'.bold.red
    else
      puts ' Invalid move! Please pick an empty spot (1-9).'.light_red.italic
    end
  end
end

main
