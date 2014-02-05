class Game < ActiveRecord::Base
  attr_accessible :name, :player1_id, :player2_id, :player1

  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  has_many :moves

  # first move is always a cross, therefore odd number of moves are always crosses
  # even numbered moves are 0

  def make_move(player, square)

    raise 'you are not my player' unless [player1_id, player2_id].include?(player.id)

    raise "it's not your turn" unless whose_turn == player

    raise 'square is not valid' unless square_is_in_bounds?(square)

    raise 'square is occupied' if square_is_occupied?(square)

    raise 'game is finished' if game_is_finished?

    moves.create player_id: player.id, square: square, symbol: which_symbol_next

  end

  public
  def which_symbol_next
    moves.count.even? ? 'X' : '0'
  end

  public
  def square_is_occupied?(square)
    moves_made_array[(square).to_i]
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
  def end_in_draw?
    moves.length == 9
  end

  private
  def are_there_squares_available?
    moves.length < 9
  end

  #helper methods: winner method 

  private 
  def winner


  end

  # [moves_made_array[0], moves_made_array[1], moves_made_array[2]]

  public
  def game_is_finished?
    return true if end_in_draw?


  #   @places = self.moves.map(&:square).sort # [0, 4, 8]
  #   @winning_combinations = [ ['0','1','2'], ['3','4','5'], ['6','7','8'], ['0','3','6'], ['1','4','7'], ['2','5','8'], ['0','4','8'], ['2','4','6'] ]

  #   @winning_combinations.each do |combo|
  #     if @places.include?(combo)
  #       if player1 == self.moves.last.player
  #       @winner = player1
  #       else
  #       @winner = player2
  #       end
  #       game_over = true
  #     end
  #   end
  # end

  # should return true if there is a winner or it's a draw

  #TODO: winner method, game_is_finished? method refactor

  # def board_is_full?
  end

  public
  def whose_turn
    if moves.count.even?
      player1
    else
      player2
    end
  end

  private
  def square_is_in_bounds?(square)
    # (0..8).include?(square)
    square = square.to_i
    square >= 0 && square <= 8
  end

end
