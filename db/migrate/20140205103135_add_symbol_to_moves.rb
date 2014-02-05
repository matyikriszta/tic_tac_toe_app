class AddSymbolToMoves < ActiveRecord::Migration
  def change
    add_column :moves, :symbol, :string
  end
end
