class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :square
      t.integer :position

      t.timestamps
    end
  end
end
