class CreateCards < ActiveRecord::Migration
  def change
  	create_table :cards do |t|
  		t.text :question, :null => false
  		t.string :answer, :null => false
  		t.integer :value
  		t.references :deck, :null => false
  		t.timestamps
  	end
  end
end
