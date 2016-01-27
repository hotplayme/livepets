class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.integer :user_id
      t.integer :score
      t.timestamps null: false
    end
  end
end
