class Game < ActiveRecord::Base
  attr_accessible :name, :player1_id, :player2_id, :player1

  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  has_many :moves

  # first move is always a cross, therefore odd number of moves are always crosses
  # even numbered moves are 0

  def make_move(player, square)
    raise 'game is finished' if game_is_finished?

    raise 'you are not my player' unless [player1_id, player2_id].include?(player.id) # works

    raise "it's not your turn" unless whose_turn == player # works

    raise 'square is not valid' unless square_is_in_bounds?(square) # works

    raise 'square is occupied' if square_is_occupied?(square) # works

    Move.create game_id: self.id, player_id: player.id, square: square, symbol: which_symbol_next

  end

  private
  def which_symbol_next
    moves.count.even? ? 'X' : '0'
  end

  public
  def square_is_occupied?(square)
    moves_made_array[square]
  end

  public
  def moves_made_array
    moves_made_array = [nil, nil, nil, nil, nil, nil, nil, nil, nil] # base case

    moves.each do |move|
      moves_made_array[move.square] = move.symbol
    end
    return moves_made_array
  end

  private
  def end_in_draw
    draw = nil
    @places = game.moves.map(&:square).sort
    if @places.length = 9
      draw = true
    end
  end

  private
  def game_is_finished? 
    game_over = nil
    @places = self.moves.map(&:square).sort # [0, 4, 8]

    @winning_combinations = [ ['0','1','2'], ['3','4','5'], ['6','7','8'], ['0','3','6'], ['1','4','7'], ['2','5','8'], ['0','4','8'], ['2','4','6'] ]

    @winning_combinations.each do |combo|
      if @places.include?(combo)
        if player1 == self.moves.last.player
        @winner = player1
        else
        @winner = player2
        end
        game_over = true
      end
    end
    unless game_over
    if @places.length < 9
      whose_turn
    else
      end_in_draw
      end
    end  
  end

  public
  def whose_turn
    if moves.count.even?
      player2
    else
      player1
    end
  end

  private
  def square_is_in_bounds?(square)
    # (0..8).include?(square)
    square >= 0 && square <= 8
  end

end

# is the game still playing? is it a finished game or a tied game? is it possible to make a move on this game?
# the person who is trying to make a move is allowed to move, am I one of the two players?
# is it their turn? 
# what happens if there alredy is a move in the square where you want to move? invalid move
# anything else to check?
# if everything is okay, create a new move (assign it to user and square and save it to the database)
# check if the game is completed? 
# def completed_game?
#   if # it's a completed game, show an error
#     # if not, do that
#   end
