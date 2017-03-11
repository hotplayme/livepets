class AddReviewsCountToBreedDefault0 < ActiveRecord::Migration
  def change
    change_column :breeds, :reviews_count, :integer, default: 0
  end
end
