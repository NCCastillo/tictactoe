class TicTacToe
  attr_reader :board_values, :winning_positions
  attr_accessor :board

  def initialize
    @board = board_game
    @board_values = board_values
    @winning_positions = winning_positions
    @current_session = true
    initialize_players
    play_game
  end

  def play_game
    @input = ""
    
    while @current_session
      print_board
      puts "Please choose position to play?" 
      @input = gets.chomp!
      @turn += 1
      break if @input == "q"
      update_board(@input)
      check_for_winner
    end

  end

  def update_board(input)
    get_board_values(input)
    set_players_positions

    check_player? ? board[@board_row][@board_col] = @p1 : board[@board_row][@board_col] = @p2
  end

  def initialize_players
    @turn = 0
    @p1, @p2 = "X", "O"
    @p1_position, @p2_position = [], []
  end

  def check_for_winner
    game_won? ? the_winner : check_tie ? tied_game : false
  end

  def game_won?
    winning_positions.each { |row| @won = true if row.sort == @p1_position.sort || row.sort == @p2_position.sort }
    @won 
  end

  def check_tie
    @turn == 9 ? true : false
  end

  def set_players_positions
    check_player? ? @p1_position << board_values.key([@board_row, @board_col]) : @p2_position << board_values.key([@board_row, @board_col])
  end

  def get_board_values(input)
    @board_row = board_values[input].fetch(0)
    @board_col = board_values[input].fetch(1)
  end

  def check_player?
    @turn.odd?
  end

  def the_winner
    @current_session = false
    print_board
    puts check_player? ? "The winner is: #{@p1}" : "The winner is: #{@p2}" 
  end


  def tied_game
    @current_session = false
    print_board
    puts "The game has been tied! Please play again!"
  end

  def board_values
    { "e1" => [0, 0],
      "e2" => [0, 1],
      "e3" => [0, 2],
      "e4" => [1, 0],
      "e5" => [1, 1],
      "e6" => [1, 2],
      "e7" => [2, 0],
      "e8" => [2, 1],
      "e9" => [2, 2],
     }
  end

  def board_game
    [
      ["e1", "e2", "e3"], 
      ["e4", "e5", "e6"],
      ["e7", "e8", "e9"],
    ]
  end

  def print_board
    board.each do |row|
      puts row.join(' | ')
      puts "---" * 4
    end
  end

  def winning_positions
    [
      ["e1", "e2", "e3"], 
      ["e4", "e5", "e6"], 
      ["e7", "e8", "e9"],
      ["e1", "e4", "e7"], 
      ["e2", "e5", "e8"], 
      ["e3", "e6", "e9"],
      ["e1", "e5", "e9"], 
      ["e7", "e5", "e3"],
      ["e1", "e5", "e7", "e4"],
      ["e1", "e5", "e7", "e9"],
      ["e1", "e5", "e3", "e2"],
      ["e1", "e5", "e3", "e9"],
      ["e1", "e5", "e3", "e7"],
      ["e2", "e5", "e4", "e6"],
      ["e3", "e5", "e6", "e4"],
      ["e3", "e5", "e9", "e6"],
      ["e3", "e5", "e9", "e7"],
      ["e3", "e5", "e9", "e1"],
      ["e3", "e1", "e6", "e4"],
      ["e5", "e1", "e6", "e4"],
      ["e7", "e5", "e9", "e8"],
      ["e7", "e5", "e6", "e4"],
      ["e7", "e5", "e9", "e1"],
      ["e7", "e5", "e9", "e3"],
      ["e8", "e5", "e4", "e6"]
    ]
  end
end


TicTacToe.new
