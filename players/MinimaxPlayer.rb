require_relative "./Player"

class MinimaxPlayer < Player
  def choose_column_and_row(game)
    @max_depth = 0
    return minimax(game).reverse
  end

  def minimax(game)
    moves = game.valid_moves

    moves.each do |move|
    end

    return moves.max_by do |move|
      new_game = game.with_move(move[1], move[0])
      minimax_helper(new_game, true, 1)
    end
  end

  def minimax_helper(game, my_turn, depth)
    if depth > @max_depth
      @max_depth = depth
      puts "  Searching depth #{depth}"
    end
      
    if game.tied?
      return 0
    end

    if game.winner
      if my_turn
      # I lost last turn!
        return -1
      else
        # I won last turn!
        return 1
      end
    end

    if my_turn
      max_score = game.valid_next_games.map do |new_game|
        minimax_helper(new_game, !my_turn, depth + 1)
      end.max
      return max_score
    else
      min_score = game.valid_next_games.map do |new_game|
        minimax_helper(new_game, !my_turn, depth + 1)
      end.min
      return min_score
    end
  end
end
