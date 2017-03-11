class AddCostToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :cost, :integer, default: 0
  end
end
