class Game < ActiveRecord::Base
  attr_accessible :name, :player1_id, :player2_id

  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  has_many :moves

  # first move is always a cross, therefore odd number of moves are always crosses
  # even numbered moves are 0

  def make_move(player)
    raise 'game is finished' if game_is_finished?

    raise 'you are not my player' unless [player1_id, player2_id].include?(player.id)

    raise "it's not you turn" unless whose_turn = player

    raise 'square is not valid' unless square_is_in_bounds

    raise 'square is occupied' if square_is_occupied?(square)

    Move.create game_id: self.id, player_id: player.id, square: square, symbol: which_symbol_next
  end

  private
  def which_symbol_next
    moves.count.even? ? 'X' : '0'
  end

  private
  def square_is_occupied?(square)
    moves_made_array[square]
  end

  public
  def moves_made_array
    a = [nil, nil, nil, nil, nil, nil, nil, nil, nil] # base case

    moves.each do |move|
      a[move.square] = move.symbol
    end
    return a
  end

    private
    def game_is_finished? 
      game_over = nil
      @places = game.moves.map(&:square).sort # [0, 4, 8]

      @winning_combinations = [ ['0','1','2'], ['3','4','5'], ['6','7','8'], ['0','3','6'], ['1','4','7'], ['2','5','8'], ['0','4','8'], ['2','4','6'] ]

      @winning_combinations.each do |combo|
        if @places.includes?(combo)
          if player1 == game.moves.last.player
          @winner = player1
          else
          @winner = player2
          end
          game_over = true
        end
      end
      unless game_over
    end

  def whose_turn?
    #TODO: write some code to return the next player
  end

  def square_is_in_bounds?(square)
    (0..8).include?(square)
      # square >= 0 && square <= 8
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
# end
