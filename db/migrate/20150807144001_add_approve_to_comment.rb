class AddApproveToComment < ActiveRecord::Migration
  def change
    add_column :comments, :approve, :boolean, default:false
  end
end
