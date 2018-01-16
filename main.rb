require_relative "Board.rb"
require_relative "GameConsole"
require_relative "iterators"
require_relative "players/Player"
require_relative "players/HumanPlayer"
require_relative "players/MinimaxPlayer"

# TODOS / ideas !!!
<<-TODOS

- successor, overflow methods and enumerators over every possible Board
- then, enumerator over every possible Game

- given a Board, enumerate all possible games that could have led to it

- AI players:
  - lookup table of perfect play (I think it's small enough)
  - graph search down all possible games
  - genetic algorithm
  - rule-based
  - test each Bot against each other on all possible games

TODOS

if false
  cm = CellMatrix.random
  cm = CellMatrix.from_strings("...", ".x.", "o..")

  puts cm
  puts '================='

  8.times do |i|
    puts i
    puts cm.rotate_right(i)
    puts
  end
end

if false
  b = Board.from_strings("...", "...", "o..")
  b = Board.empty
  current = b

  puts current
  p current
  puts

  moves = [
    [0, 0, Cell::X],
    [0, 1, Cell::O],
    [0, 2, Cell::X],
  ].each do |row, col, cell|
    current = current.with_cell(row, col, cell)
    puts current
    p current
    puts
  end
end

if false
  game = Game.new
  while true
    puts game.player_to_move
    p game.current_board
    
    while true
      begin
        puts game.move_instructions
        input = gets
        game = game.with_move(input)
        puts
      rescue Game::InvalidMoveInput => e
        puts e.message
      end
    end
  end
end

if true
  p1 = HumanPlayer.new('Thomas')
  p2 = HumanPlayer.new('Madeline')

  p1 = HumanPlayer.new('Thomas')
  p2 = MinimaxPlayer.new('HAL')

  GameConsole.new(3, p2, p1).run
end

if false
  #p CellIterator.new.each.map
  boards = [
    Board.empty,
    Board.from_strings('...', '...', '..x'),
    Board.from_strings('...', '...', '..o'),
    Board.from_strings('x..', '...', '...'),
    Board.from_strings('ooo', 'ooo', 'ooo'),
    Board.from_strings('oxo', '..x', '.ox'),
  ]

  boards.each {|board| p board; p BoardIterator.to_i(board)}
end

if false
  i = 16801
  puts i
  puts
  BoardIterator.from_i(i)
end

if false
  b = Board.from_strings(
    'oo.',
    '.x.',
    '.xx',
  )

  g = Game.new(3, [b])

  p g
  puts
  g.valid_next_games.each {|ng| p ng; puts}
end

