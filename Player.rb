class Player
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def choose_column_and_row(board)
    raise "subclass must implement!"
  end
end

class HumanPlayer < Player
  class InvalidMoveInput < ArgumentError; end
  
  def choose_column_and_row(board)
    while true
      begin
        print "#{name} > "
        input = gets
        column, row = self.class.parse_input(input)
        return column, row
      rescue InvalidMoveInput => e
        puts e.message
      end
    end
  end

  def self.parse_input(input)
    numbers = input.split.map(&:to_i)
    
    if numbers.size != 2
      raise InvalidMoveInput.new("You must type two numbers separated by a space.")
    end

    # [column, row]
    numbers
  end
end

class Autobot < Player
  def initialize(name, moves)
    @name = name
    @moves = moves
    @index = 0
  end
  
  def choose_column_and_row(board)
    move = @moves[@index]
    @index += 1
    move
  end
end

class RandomPlayer < Player
  def choose_column_and_row(board)
    pairs = board.size.times.flat_map {|i| board.size.times.map {|j| [i, j]}}
    valid_pairs = pairs.select do |column, row|
      board.get_cell(row, column).empty?
    end
    valid_pairs.sample
  end
end
