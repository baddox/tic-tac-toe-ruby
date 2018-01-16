require_relative "./Player"

class RandomPlayer < Player
  def choose_column_and_row(game)
    board = game.current_board
    pairs = board.size.times.flat_map {|i| board.size.times.map {|j| [i, j]}}
    valid_pairs = pairs.select do |column, row|
      board.get_cell(row, column).empty?
    end
    valid_pairs.sample
  end
end
