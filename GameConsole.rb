require_relative "./game"

class GameConsole
  # This launches an interactive game on the terminal

  def initialize(size, player_x, player_o)
    @size = size
    @player_x = player_x
    @player_o = player_o
    @game = Game.new(@size)
  end

  def run
    # THE game loop.
    while true
      # Loop over moves, alternating between players,
      # until the game is over!
      
      if @game.over?
        puts end_message
        p @game.current_board
        return
      end

      puts move_message
      p @game.current_board
      
      while true
        # Get moves from the player_to_move until
        # we get a valid and legal one.
        begin
          column, row = player_to_move.
                        choose_column_and_row(@game)
          @game = @game.with_move(column, row)
          puts
          break
        rescue Game::MoveOutOfBounds => e
          puts "Those coordinates are not valid!"
        rescue Game::MoveNotEmpty => e
          puts "That spot isn't empty! Please choose an empty spot."
        end
      end
    end
  end

  def player_to_move
    @game.cell_to_move.x? ? @player_x : @player_o
  end

  def move_message
    name = player_to_move.name
    symbol = @game.cell_to_move.to_s
    "#{name}, it is your turn! Place a #{symbol} in an empty spot!"
  end

  def winner
    if @game.winner
      @game.winner.x? ? @player_x : @player_o
    else
      nil
    end
  end

  def end_message
    if @game.tied?
      puts "Game over. It was a draw!"
    else
      puts "Game over. Congratulations #{winner.name}, you are victorious!"
    end

  end
end
