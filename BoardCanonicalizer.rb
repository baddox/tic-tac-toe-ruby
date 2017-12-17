module BoardCanonicalizer
  def columns
    rows.transpose
  end

  def rotate_right
    Board.new(@size, columns.map(&:reverse))
  end

  def reflect_horizontally
    Board.new(@size, rows.map(&:reverse))
  end

  def to_i
    # a representation in radix 3.
    # e.g. this Board:
    #
    # X| | 
    #  | | 
    #  |X|
    #
    # will be 100_000_010 in base 3 because X is in the first and
    # penultimate position, X has value 1, and EMPTY has value 0.
    sum = 0
    rows.flatten.reverse.each.with_index do |cell, i|
      power = 3 ** i
      sum += cell.to_i * power
    end
    sum
  end

  def <=>(other)
    other.to_i <=> self.to_i
  end

  def canonicalize
    candidate_boards.min
  end

  def candidate_boards
    rotated_90 = rotate_right
    rotated_180 = rotated_90.rotate_right
    rotated_270 = rotated_180.rotate_right
    [
      self,
      rotated_90,
      rotated_180,
      rotated_270,
      self.reflect_horizontally,
      rotated_90.reflect_horizontally,
      rotated_180.reflect_horizontally,
      rotated_270.reflect_horizontally,
    ]
  end
end
