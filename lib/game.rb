# frozen_string_literal: true

class Game
  def initialize
    @hash = { '1' => '1', '2' => '2', '3' => '3', '4' => '4', '5' => '5', '6' => '6', '7' => '7', '8' => '8',
              '9' => '9' }
  end

  def board
    puts " \n\n #{@hash['1']} | #{@hash['2']} | #{@hash['3']}\n ---------- \n #{@hash['4']} | #{@hash['5']} | #{@hash['6']} \n ---------- \n #{@hash['7']} | #{@hash['8']} | #{@hash['9']}\n\n"
  end

  def update_board(pos, symbol)
    @hash[pos] = symbol if @hash[pos] == pos
  end

  def end_game?
    rows = [1, 4, 7].map { |i| [@hash[i.to_s], @hash[(i + 1).to_s], @hash[(i + 2).to_s]] }
    columns = [1, 2, 3].map { |i| [@hash[i.to_s], @hash[(i + 3).to_s], @hash[(i + 6).to_s]] }
    diagonal = [[@hash['1'], @hash['5'], @hash['9']], [@hash['3'], @hash['5'], @hash['7']]]

    entry = rows + columns + diagonal

    if entry.any? { |r| r.all? { |cell| cell.uncolorize.downcase == 'x' } }
      'X WON!'
    elsif entry.any? { |r| r.all? { |cell| cell.uncolorize.downcase == 'o' } }
      'O WON!'
    elsif entry.flatten.uniq.length == 2
      "IT'S A TIE!"
    else
      false
    end
  end
end
