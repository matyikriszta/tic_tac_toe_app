class Player < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :game_id, :move_id, :name, :user_image, :password, :password_confirmation, :role

  has_many :games_as_player1, class_name: 'Game', foreign_key: :player1_id
  has_many :games_as_player2, class_name: 'Game', foreign_key: :player2_id

  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates :email, uniqueness: true

  mount_uploader :player_image, PlayerImageUploader

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end
end
