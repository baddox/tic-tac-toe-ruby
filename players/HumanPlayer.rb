require_relative "./Player"

class HumanPlayer < Player
  class InvalidMoveInput < ArgumentError; end
  
  def choose_column_and_row(game)
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

