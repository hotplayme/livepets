class AddCommentToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :comment, :string, default: 'на проверке'
  end
end
