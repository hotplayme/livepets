class AddFileToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :file, :string
  end
end
