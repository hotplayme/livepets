class AddBodySizeToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :body_size, :integer
  end
end
