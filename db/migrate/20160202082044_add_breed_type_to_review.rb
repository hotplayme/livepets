class AddBreedTypeToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :breed_type, :string
  end
end
