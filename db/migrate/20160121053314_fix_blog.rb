class FixBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :payed, :boolean, default: false
  end
end
