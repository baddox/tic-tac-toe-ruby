require_relative "./Board"
require_relative "./Cell"
require_relative "./GameIterator"

class Game
  # A Game is a series of Boards, each the result of
  # legal moves. This class enforces the rules.
  # It's really just game logic around a single Board,
  # but it's immutable and thus could be trivially
  # refactored by renaming this to GameState and having
  # a new Game class that remembers the history.
  
  # TODO Or alternatively, still make it immutable,
  # and have with_move return a new Game with the new
  # Board pushed onto its history. Feels odd to have
  # Game instances by immutable but also store their
  # history, but it's a reasonable API imo.

  include ::GameIterator
  
  class InvalidMove < ArgumentError; end
  class MoveOutOfBounds < InvalidMove; end
  class MoveNotEmpty < InvalidMove; end

  attr_reader :size
  
  def initialize(size, board_history = [Board.empty(size)])
    @size = size
    @board_history = board_history
  end

  def current_board
    @board_history.last
  end

  def cell_to_move
    if @cell_to_move.nil?
      cells = current_board.rows.flatten
      x_count = cells.count(Cell::X)
      o_count = cells.count(Cell::O)
      @cell_to_move =
        x_count <= o_count ? Cell::X : Cell::O
    end

    @cell_to_move
  end

  def with_move(column, row)
    numbers = [column, row]

    if numbers.any? {|number| !number.is_a?(Integer)}
      raise ArgumentError.new("column and row must both be integers")
    end
    
    if numbers.any? {|number| number < 0 || number >= @size}
      raise MoveOutOfBounds
    end

    target_cell = current_board.get_cell(row, column)
    
    if !target_cell.empty?
      raise MoveNotEmpty
    end

    new_board = current_board.with_cell(
      row,
      column,
      cell_to_move,
    )
    new_boards = @board_history + [new_board]
    Game.new(@size, new_boards)
  end

  def over?
    winner || tied?
  end

  def full?
    current_board.rows.flatten.none?(&:empty?)
  end

  def tied?
    full? && !winner
  end

  def winnable_sets
    # Every @size-in-a-row that would cause a victory
    sets = []

    sets.concat(current_board.rows)
    sets.concat(current_board.columns)

    top_left_diagonal = @size.times.map do |i|
      [i, i]
    end

    top_right_diagonal = @size.times.map do |i|
      [i, @size - i]
    end

    diagonals = [top_left_diagonal, top_right_diagonal].map do |diag|
      diag.map {|row, column| current_board.get_cell(row, column)}
    end
    sets.concat(diagonals)
    
    sets
  end

  def winner
    winnable_sets.each do |set|
      if winning_cell = self.class.winner_of_cells(set)
        return winning_cell
      end
    end
    return nil
  end

  def self.winner_of_cells(cells)
    if cells.uniq.size == 1 && !cells.first.empty?
      cells.first
    else
      nil
    end
  end
end
