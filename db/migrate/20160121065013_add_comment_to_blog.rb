class AddCommentToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :comment, :string, default: 'wait approve'
  end
end
