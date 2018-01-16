require_relative "./Player"

class Autobot < Player
  def initialize(name, moves)
    @name = name
    @moves = moves
    @index = 0
  end
  
  def choose_column_and_row(game)
    move = @moves[@index]
    @index += 1
    move
  end
end
