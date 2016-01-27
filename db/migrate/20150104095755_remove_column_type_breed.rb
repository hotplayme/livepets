class RemoveColumnTypeBreed < ActiveRecord::Migration
  def change
    remove_column :breeds, :type
  end
end
