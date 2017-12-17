class Cell
  EMPTY = Cell.new
  X = Cell.new
  O = Cell.new
  
  def empty?
    self == EMPTY
  end
  
  def x?
    self == X
  end
  
  def o?
    self == O
  end

  def to_s
    case self
    when EMPTY; " "
    when X; "X"
    when O; "O"
    end
  end
  
  def to_i
    case self
    when EMPTY; 0
    when X; 1
    when O; 2
    end
  end
  
  def <=>(other)
    other.to_i <=> self.to_i
  end

  def self.random
    [EMPTY, X, O].sample
  end

  def self.from_char(char)
    case char.downcase
    when "x"
      X
    when "o"
      O
    when " ", "-", "_", "."
      EMPTY
    else
      raise ArgumentError.new("invalid character: #{char.inspect}")
    end
  end
end
