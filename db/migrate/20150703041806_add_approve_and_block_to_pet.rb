class AddApproveAndBlockToPet < ActiveRecord::Migration
  def change
    add_column :mypets, :approve, :boolean, default: false
    add_column :mypets, :block,   :boolean, default: false
  end
end
