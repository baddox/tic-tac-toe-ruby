module GameIterator

  def valid_moves
    return [] if self.over?
    
    empty_moves = []
    
    current_board.rows.each.with_index do |row, i|
      row.each.with_index do |cell, j|
        empty_moves << [i, j] if cell.empty?
      end
    end

    empty_moves
  end
  
  def valid_next_games
    valid_moves.map {|(i, j)| self.with_move(j, i)}
  end

end
