class Move < ActiveRecord::Base
  attr_accessible :game_id, :position, :player_id, :square, :player

  # symbol?

  belongs_to :player, class_name: 'Player'
  belongs_to :game

  # def move
  #   @move.first == 'X'
  # end
end
