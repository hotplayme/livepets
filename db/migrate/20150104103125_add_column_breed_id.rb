class AddColumnBreedId < ActiveRecord::Migration
  def change
    add_column :mypets, :breed_id, :integer
  end
end
