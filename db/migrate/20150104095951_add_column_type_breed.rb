class AddColumnTypeBreed < ActiveRecord::Migration
  def change
    add_column :breeds, :breed_type, :string
  end
end
