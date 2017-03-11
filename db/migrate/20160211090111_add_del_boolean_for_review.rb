class AddDelBooleanForReview < ActiveRecord::Migration
  def change
    add_column :reviews, :del, :boolean, default: false
  end
end
