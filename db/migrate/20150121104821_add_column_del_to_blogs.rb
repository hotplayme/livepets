class AddColumnDelToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :del, :boolean, default: false
  end
end
