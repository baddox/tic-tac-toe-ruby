class Player
  attr_reader :name
  
  def initialize(name)
    @name = name
    setup
  end

  def setup
  end

  def choose_column_and_row(game)
    raise "subclass must implement!"
  end
end
