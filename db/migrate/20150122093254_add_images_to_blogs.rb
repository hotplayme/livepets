class AddImagesToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :images, :text
  end
end
