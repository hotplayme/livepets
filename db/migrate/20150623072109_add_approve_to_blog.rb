class AddApproveToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :approve, :boolean, default: false
  end
end
