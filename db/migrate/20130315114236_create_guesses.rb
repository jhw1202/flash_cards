class CreateGuesses < ActiveRecord::Migration
  def change
  	create_table :guesses do |t|
  		t.references :round, :null => false
  		t.references :card, :null => false
  		t.boolean :correct, :null => false
  		t.timestamps
  	end
  end
end
