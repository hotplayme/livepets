class AddIndexUserIdToMypets < ActiveRecord::Migration
  def change
    add_index :mypets, :user_id
    add_index :mypets, :breed_id
  end
end
