class AddReviewsCountToBreed < ActiveRecord::Migration
  def change
    add_column :breeds, :reviews_count, :integer
  end
end
