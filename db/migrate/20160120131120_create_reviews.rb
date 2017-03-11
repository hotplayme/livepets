class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id, index: true
      t.integer :breed_id, index: true
      t.integer :views
      t.integer :comments_count
      t.integer :votes_count
      t.text    :body
      t.timestamps null: false
    end
  end
end
