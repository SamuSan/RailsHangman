class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :game_id, null: false
      t.index :game_id
      t.string :guess, null: false
      t.timestamps
    end
  end
end
