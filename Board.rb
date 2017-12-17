require_relative "./Cell"
require_relative "./BoardCanonicalizer"

class Board
  # A Board is a game state that may or may not be a possible
  # state reached in a game. 
  # It knows nothing about the game except that there is a
  # @size-by-@size grid of cells.
  
  include ::BoardCanonicalizer

  class InvalidMatrix < ArgumentError; end
  
  attr_reader :size
  
  def initialize(size, matrix)
    # matrix is an Array of size rows,
    # each row is an Array of size Cells.
    self.class.validate_matrix(size, matrix)
    @size = size
    @matrix = matrix
  end

  def get_cell(row, column)
    @matrix[row][column]
  end

  def with_cell(row, column, cell)
    if row < 0 || row >= @size || column < 0 || column >= @size
      raise ArgumentError.new("row and column must be in 0..#{size}")
    end
    
    new_matrix = rows
    new_matrix[row][column] = cell
    Board.new(@size, new_matrix)
  end

  def rows
    # dup to make sure @matrix is immutable
    @matrix.map(&:dup)
  end

  def slug
    rows.map {|row| row.map(&:to_s).join("")}.join("|")
  end

  def to_s
    %{<Board #{@size}x#{@size}>}
  end

  def ascii_grid
    rows.map {|row| row.join("|")}.join("\n")
  end

  def inspect
    ascii_grid
  end
  
  def self.empty(size)
    matrix = size.times.map {size.times.map {Cell::EMPTY}}
    Board.new(size, matrix)
  end

  def self.random(size)
    matrix = size.times.map {size.times.map {Cell.random}}
    Board.new(size, matrix)
  end

  def self.random_valid
    # TODO
  end

  def self.from_strings(*rows)
    matrix = rows.map {|row| row.chars.map {|char| Cell.from_char(char)}}
    Board.new(matrix.size, matrix)
  end

  def self.validate_matrix(size, matrix)
    if !size.is_a?(Integer) || size <= 0
      raise InvalidMatrix.new("size must be an Integer >= 1")
    end
    
    if matrix.size != size
      raise InvalidMatrix.new("matrix must have #{size} rows")
    end

    if matrix.any? {|row| row.size != size}
      raise InvalidMatrix.new("each row in matrix must have #{size} cells")
    end

    if first = matrix.find {|row| row.find {|cell| !cell.is_a? Cell}}
      raise InvalidMatrix.new("matrix must contain only Cells, you provided #{first.inspect}")
    end
  end
end
